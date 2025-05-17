return {
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
    -- enabled = false,
    config = function()
      require("kanso").setup({})
      vim.cmd.colorscheme("kanso")
      vim.api.nvim_set_hl(0, "String", { fg = "#A08070" })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      --- @diagnostic disable
      require("kanagawa").setup({
        colors = {
          theme = { all = { ui = { bg_gutter = "none" } } },
        },
        background = {
          dark = "dragon",
          light = "lotus",
        },
      })

      vim.cmd.colorscheme("kanagawa")
    end,
  },
}
