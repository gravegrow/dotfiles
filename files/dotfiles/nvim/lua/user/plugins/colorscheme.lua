return {
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
  -- {
  --   "kyza0d/xeno.nvim",
  --   lazy = false,
  --   priority = 1000, -- Load colorscheme early
  --   config = function()
  --     -- Create your custom theme here
  --     require("xeno").new_theme("xeno-theme", {
  --       base = "#161617",
  --       accent = "#D19EBC",
  --       contrast = 0.3,
  --     })
  --     vim.cmd("colorscheme xeno-theme")
  --   end,
  -- },
  {
    "vague2k/vague.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other plugins
    enabled = false,
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require("vague").setup({
        -- optional configuration here
      })
      vim.cmd("colorscheme vague")
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
