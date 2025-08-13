return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "xzbdmw/colorful-menu.nvim",
      "rafamadriz/friendly-snippets",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    version = "1.*",
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
      sources = {
        providers = {
          buffer = {
            max_items = 3,
            min_keyword_length = 4,
          },
          snippets = {
            should_show_items = function()
              local trigger = ":"
              local col = vim.api.nvim_win_get_cursor(0)[2]
              local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
              return before_cursor:match(trigger .. "%w*$") ~= nil
            end,
            transform_items = function(_, items)
              local trigger = ":"
              local col = vim.api.nvim_win_get_cursor(0)[2]
              local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
              local trigger_pos = before_cursor:find(trigger .. "[^" .. trigger .. "]*$")
              if trigger_pos then
                for _, item in ipairs(items) do
                  if not item.trigger_text_modified then
                    ---@diagnostic disable-next-line: inject-field
                    item.trigger_text_modified = true
                    item.textEdit = {
                      newText = item.insertText or item.label,
                      range = {
                        start = { line = vim.fn.line(".") - 1, character = trigger_pos - 1 },
                        ["end"] = { line = vim.fn.line(".") - 1, character = col },
                      },
                    }
                  end
                end
              end
              return items
            end,
          },
        },
      },
      completion = {
        documentation = {
          auto_show = false,
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
          max_height = 8,
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
          direction_priority = { "n" },
          show_documentation = true,
        },
      },
    },
  },
}
