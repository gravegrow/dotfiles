return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local lualine = require "lualine"
    local colors = {
      base = vim.g.get_bg "Normal",
      text = vim.g.get_fg "Normal",
      surface = vim.g.get_bg "NormalFloat",
      muted = vim.g.get_fg "Comment",
      iris = vim.g.get_fg "CursorLineNr",
    }

    local theme = {
      normal = {
        a = { fg = colors.text, bg = colors.base, gui = "bold" },
        b = { fg = colors.text, bg = colors.surface },
        c = { fg = colors.muted, bg = colors.surface },
      },
    }

    local filetype_icon = {
      "filetype",
      icon_only = true,
      padding = { left = 1, right = -1 },
    }

    local width_cond = function()
      return vim.o.columns > 65
    end

    local lsp = {
      function()
        local msg = ""
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          if client.name ~= "ruff" then
            return client.name:gsub("_", "-")
          end
        end
        return msg
      end,
      padding = { left = -1, right = 1 },
      color = {
        fg = colors.text,
        gui = "bold",
      },
    }

    local location = {
      function()
        return "%l:%L"
      end,
      color = { fg = colors.iris, gui = "bold" },
    }

    local diagnostics = {
      "diagnostics",
      symbols = { error = " ", warn = " ", info = " ", hint = "󰰁 " },
      sections = { "error", "warn" },
      padding = { left = -1, right = 1 },
    }

    local simple_extension = function(filetype, display_name)
      return {
        sections = {
          -- stylua: ignore
          lualine_a = { function() return display_name end, },
          lualine_b = { filetype_icon },
        },
        filetypes = { filetype },
      }
    end

    lualine.setup({
      options = {
        theme = theme,
        component_separators = "",
        section_separators = { left = "", right = "" },
      },

      sections = {
        lualine_a = {},
        lualine_b = {
          filetype_icon,
          lsp,
          diagnostics,
        },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { { "branch", icon = "", cond = width_cond } },
        lualine_y = { location },
        lualine_z = {},
      },
      extensions = {
        "quickfix",
        simple_extension("harpoon", "Harpoon"),
        simple_extension("minifiles", "Minifiles"),
        simple_extension("TelescopePrompt", "Telescope"),
        simple_extension("lazy", "Lazy"),
        simple_extension("mason", "Mason"),
        simple_extension("undotree", "Undotree"),
        simple_extension("help", "Help"),
      },
    })
  end,
}
