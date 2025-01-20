return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local lualine = require("lualine")
    local colors = {
      text = vim.g.get_fg("StatusLine"),
      statusline = vim.g.get_bg("StatusLine"),
      comment = vim.g.get_fg("Comment"),
    }

    local theme = {
      normal = {
        b = { fg = colors.text, bg = colors.statusline, gui = "bold" },
        c = { fg = colors.comment, bg = colors.statusline },
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
    }

    local location = {
      function()
        return "%l:%L"
      end,
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
          lualine_b = {
            filetype_icon,
            {
              function()
                return display_name
              end,
              padding = { left = -1, right = 1 },
            },
          },
          lualine_y = { location },
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
        simple_extension("man", "Manual"),
      },
    })
  end,
}
