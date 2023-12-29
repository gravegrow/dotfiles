return {}
--[[ return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "BufReadPre",
  opts = {
    options = {
      indicator = { style = "none", icon = "" },

      modified_icon = "[+]",
      buffer_close_icon = "",
      offsets = {
        {
          filetype = "NvimTree",
          text_align = "center",
          text = "",
          highlight = "BufferLineFill",
        },
      },
    },
    highlights = {
      buffer_visible = {
        bg = {
          attribute = "bg",
          highlight = "Normal",
        },
      },
    },
  },
  config = function(_, opts)
    local bufferline = require "bufferline"
    opts.options.style_preset = {
      bufferline.style_preset.no_italic,
    }

    local cycle = {
      next = function()
        bufferline.cycle(1)
      end,
      prev = function()
        bufferline.cycle(-1)
      end,
    }

    vim.keymap.set({ "n", "v" }, "L", cycle.next)
    vim.keymap.set({ "n", "v" }, "H", cycle.prev)

    bufferline.setup(opts)
  end,
} ]]
