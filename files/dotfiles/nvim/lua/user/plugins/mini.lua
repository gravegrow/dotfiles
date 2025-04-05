return {
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  import = "user.plugins.mini",
  config = function(_, opts)
    require("mini.align").setup()
    require("mini.splitjoin").setup()
    require("mini.surround").setup()

    require("mini.files").setup(opts.files)

    require("mini.icons").setup({
      extension = {
        cpp = { glyph = "" },
        h = { glyph = "󰰀" },
      },
    })
    require("mini.icons").mock_nvim_web_devicons()
    require("mini.hipatterns").setup(opts.hipatterns)
  end,
}
