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
        -- documentation = cmp.config.window.bordered({
        --   winhighlight = "Normal:NormalFloatSec,FloatBorder:FloatBorderSec,Error:None",
        -- }),
      },
      formatting = {
        fields = { "kind", "abbr" },
        format = function(entry, vim_item)
          -- vim_item.menu = "(" .. (vim_item.kind or "") .. ")" or nil
          vim_item.kind = " " .. (kind_icons[vim_item.kind] or "") .. ""
          vim_item.menu = nil

          local label = vim_item.abbr or ""
          local width = 25

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
          cmp.config.compare.offset,
          cmp.config.compare.exact,

          -- copied from cmp-under
          function(entry1, entry2)
            local _, entry1_under = entry1.completion_item.label:find("^_+")
            local _, entry2_under = entry2.completion_item.label:find("^_+")
            entry1_under = entry1_under or 0
            entry2_under = entry2_under or 0
            if entry1_under > entry2_under then
              return false
            elseif entry1_under < entry2_under then
              return true
            end
          end,

          cmp.config.compare.score,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
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
