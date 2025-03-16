return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "xzbdmw/colorful-menu.nvim",
      "rafamadriz/friendly-snippets",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    version = "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      cmdline = { completion = { menu = { auto_show = true } } },
      keymap = {
        preset = "default",
        ["<C-L>"] = { "snippet_forward", "fallback" },
        ["<C-H>"] = { "snippet_backward", "fallback" },
        ["<C-U>"] = { "scroll_documentation_up", "fallback" },
        ["<C-D>"] = { "scroll_documentation_down", "fallback" },
      },
      appearance = { use_nvim_cmp_as_default = true },
      completion = {
        documentation = {
          window = {
            min_width = 63,
            max_width = 63,
            border = "single",
            direction_priority = {
              menu_north = { "n" },
              menu_south = { "n" },
            },
          },
        },
        menu = {
          draw = {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                width = { fill = true, min = 35, max = 60 },
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
      },
      signature = {
        enabled = true,
        trigger = { show_on_insert = true },
        window = {
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder",
          show_documentation = true,
        },
      },
    },
  },
}
