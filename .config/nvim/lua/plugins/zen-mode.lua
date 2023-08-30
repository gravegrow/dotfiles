return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  keys = { { "<leader>z", "<cmd>ZenMode<cr>" } },
  opts = {
    window = {
      backdrop = 1.0,
      height = 0.95,
      options = {
        -- signcolumn = "no", -- disable signcolumn
        number = false,         -- disable number column
        relativenumber = false, -- disable relative numbers
        -- cursorline = false, -- disable cursorline
        -- cursorcolumn = false, -- disable cursor column
        -- foldcolumn = "0", -- disable fold column
        -- list = false, -- disable whitespace characters
      },
    },
  },
}
