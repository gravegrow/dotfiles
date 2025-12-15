return {
  {
    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    config = function()
      vim.g.zenbones_darken_comments = 45
      -- vim.cmd.colorscheme("zenbones")

      -- vim.api.nvim_set_hl(0, "String", { fg = "#A1938C", italic = true })
    end,
  },
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
    -- enabled = false,
    config = function()
      require("kanso").setup({})
      vim.cmd.colorscheme("kanso")
      vim.api.nvim_set_hl(0, "String", { fg = "#B6927B" })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    -- enabled = false,
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

      -- vim.cmd.colorscheme("kanagawa")
    end,
  },
}
