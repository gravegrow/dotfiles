local kind_icons = {
  Text = "󰉿",
  Method = "󰊕",
  Function = "󰊕",
  Constructor = "󰒓",

  Field = "󰜢",
  Variable = "󰆦",
  Property = "󰖷",

  Class = "󱡠",
  Interface = "󱡠",
  Struct = "󱡠",
  Module = "󰅩",

  Unit = "󰪚",
  Value = "󰦨",
  Enum = "󰦨",
  EnumMember = "󰦨",

  Keyword = "󰻾",
  Constant = "󰏿",

  Snippet = "󱄽",
  Color = "󰏘",
  File = "󰈔",
  Reference = "󰬲",
  Folder = "󰉋",
  Event = "󱐋",
  Operator = "󰪚",
  TypeParameter = "󰬛",
}

return {
  "iguanacucumber/magazine.nvim",
  name = "nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      build = (function()
        return "make install_jsregexp"
      end)(),
    },
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    luasnip.config.setup()
    require("luasnip.loaders.from_vscode").lazy_load()
    local lspkind_comparator = function(conf)
      local lsp_types = require("cmp.types").lsp
      return function(entry1, entry2)
        if entry1.source.name ~= "nvim_lsp" then
          if entry2.source.name == "nvim_lsp" then
            return false
          else
            return nil
          end
        end

        local _, entry1_under = entry1.completion_item.label:find("^_+")
        local _, entry2_under = entry2.completion_item.label:find("^_+")
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end

        local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
        local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

        local priority1 = conf.kind_priority[kind1] or 0
        local priority2 = conf.kind_priority[kind2] or 0
        if priority1 == priority2 then
          return cmp.config.compare.score(entry1, entry2)
        end
        return priority2 < priority1
      end
    end

    local label_comparator = function(entry1, entry2)
      return entry1.completion_item.label < entry2.completion_item.label
    end

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<c-space>"] = cmp.mapping({
          i = cmp.mapping.complete(),
          c = function(_)
            if cmp.visible() then
              if not cmp.confirm({ select = true }) then
                return
              end
            else
              cmp.complete()
            end
          end,
        }),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-y>"] = cmp.mapping(
          cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          { "i", "c" }
        ),
        ["<M-y>"] = cmp.mapping(
          cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }),
          { "i", "c" }
        ),
        ["<C-l>"] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),
      }),
      preselect = cmp.PreselectMode.None,
      window = {
        completion = { col_offset = -2, side_padding = 0 },
        documentation = cmp.config.window.bordered({
          winhighlight = "Normal:NormalFloatSec,FloatBorder:FloatBorderSec,Error:None",
        }),
      },
      formatting = {
        fields = { "kind", "abbr" },
        format = function(entry, vim_item)
          -- vim_item.menu = "(" .. (vim_item.kind or "") .. ")" or nil
          vim_item.kind = " " .. (kind_icons[vim_item.kind] or "") .. ""
          vim_item.menu = nil

          local label = vim_item.abbr or ""
          local width = 35

          if string.len(label) > width then
            vim_item.abbr = vim_item.abbr:sub(1, width - 2) .. "··"
          end

          if string.len(label) < width then
            local padding = string.rep(" ", width - string.len(label))
            vim_item.abbr = label .. padding
          end

          return vim_item
        end,
      },
      sources = cmp.config.sources({
        {
          name = "lazydev",
          group_index = 0,
        },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer" },
      }),
      sorting = {
        comparators = {
          cmp.config.compare.recently_used,
          -- cmp.config.compare.offset,
          cmp.config.compare.exact,

          lspkind_comparator({
            kind_priority = {
              Snippet = 13,
              Field = 12,
              Property = 11,
              Constant = 10,
              Enum = 10,
              EnumMember = 10,
              Event = 10,
              Function = 10,
              Method = 10,
              Operator = 10,
              Reference = 10,
              Struct = 10,
              Variable = 9,
              File = 8,
              Folder = 8,
              Class = 5,
              Color = 5,
              Module = 5,
              Keyword = 2,
              Constructor = 1,
              Interface = 1,
              Text = 1,
              TypeParameter = 1,
              Unit = 1,
              Value = 1,
            },
          }),
          label_comparator,
          cmp.config.compare.score,

          -- cmp.config.compare.recently_used,
          -- cmp.config.compare.offset,
          -- cmp.config.compare.exact,

          -- function(entry1, entry2)
          --   local _, entry1_under = entry1.completion_item.label:find("^_+")
          --   local _, entry2_under = entry2.completion_item.label:find("^_+")
          --   entry1_under = entry1_under or 0
          --   entry2_under = entry2_under or 0
          --   if entry1_under > entry2_under then
          --     return false
          --   elseif entry1_under < entry2_under then
          --     return true
          --   end
          -- end,

          -- cmp.config.compare.score,
          -- cmp.config.compare.kind,
          -- cmp.config.compare.sort_text,
          -- cmp.config.compare.length,
          -- cmp.config.compare.order,
        },
      },
    })

    local opts = {
      mapping = cmp.mapping.preset.cmdline({
        ["<C-y>"] = { c = cmp.mapping.confirm({ select = true }) },
      }),
      formatting = {
        fields = { "kind", "abbr" },
        format = function(entry, vim_item)
          vim_item.kind = kind_icons[vim_item.kind] or ""

          local label = vim_item.abbr or ""
          local width = 20

          if string.len(label) < width then
            local padding = string.rep(" ", width - string.len(label))
            vim_item.abbr = label .. padding
          end
          return vim_item
        end,
      },
      window = {
        completion = cmp.config.window.bordered({
          border = "single",
          winhighlight = "Normal:Normal,FloatBorder:@attribute,Error:None",
        }),
      },
    }

    local buf_opts = { sources = { { name = "buffer" } } }
    local cmd_opts = { sources = cmp.config.sources({ { name = "path" }, { name = "cmdline" } }) }

    cmp.setup.cmdline({ "/", "?" }, vim.tbl_extend("force", opts, buf_opts))
    cmp.setup.cmdline(":", vim.tbl_extend("force", opts, cmd_opts))
  end,
}
