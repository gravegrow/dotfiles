return {
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    event = { "InsertEnter", "CmdlineEnter" },
    enabled = true,
    version = "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "default",
        ["<C-L>"] = { "snippet_forward", "fallback" },
        ["<C-H>"] = { "snippet_backward", "fallback" },
        ["<C-U>"] = { "scroll_documentation_up", "fallback" },
        ["<C-D>"] = { "scroll_documentation_down", "fallback" },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = {
          auto_show = false,
          window = {
            direction_priority = {
              menu_north = { "n" },
              menu_south = { "n" },
            },
          },
        },
        menu = {
          draw = {
            components = {
              label = { width = { min = 35, max = 35 } },
            },
          },
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      signature = {
        enabled = true,
        window = {
          max_height = 10,
          border = "padded",
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder",
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
