local M = {}

M.cmp_config = function()
  local cmp = require "cmp"
  local formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = require("lspkind").cmp_format { mode = "symbol_text", maxwidth = 50 } (entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. (strings[1] or "") .. " "
      kind.menu = "    (" .. (strings[2] or "") .. ")"

      return kind
    end,
  }

  local options = {
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        require("cmp-under-comparator").under,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    window = {
      completion = {
        side_padding = 0,
        scrollbar = false,
        col_offset = -3,
        winhighlight = "Normal:CmpNormal,FloatBorder:CmpFloatBorder,CursorLine:CursorLine,Search:CmpSearch",
      },
      documentation = {
        winhighlight = "Normal:CmpDoc,FloatBorder:CmdDocBorder",
      },
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    formatting = formatting,
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ["<Tab>"] = cmp.mapping(function(fallback)
        if require("luasnip").expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if require("luasnip").jumpable(-1) then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    },
    sources = {
      { name = "luasnip" },
      { name = "quickgd" },
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "buffer" },
    },
    -- view = {
    --   entries = { name = "custom", selection_order = "near_cursor" },
    -- },
  }

  cmp.setup(options)

  local ok, autopairs = pcall(require, "nvim-autopairs.completion.cmp")

  if not ok then
    return
  end

  cmp.event:on("confirm_done", autopairs.on_confirm_done())
end

M.luasinip_config = function()
  local options = { history = true, updateevents = "TextChanged,TextChangedI" }
  local luasnip = require "luasnip"

  luasnip.config.set_config(options)

  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }

  require("luasnip.loaders.from_snipmate").load()
  require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }

  require("luasnip.loaders.from_lua").load()
  require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }

  local s = luasnip.snippet
  local f = luasnip.function_node

  luasnip.add_snippets("all", {
    s(
      "dateDMY",
      f(function()
        return os.date "%d/%m/%Y"
      end)
    ),
  })

  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      if
          require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
          and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
    end,
  })
end

return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      M.cmp_config()
      M.luasinip_config()
    end,
    dependencies = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "lukas-reineke/cmp-under-comparator",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
    },
  },
}
