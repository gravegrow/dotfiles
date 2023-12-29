return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require("neogen").setup {
      snippet_engine = "luasnip",
      languages = {
        lua = {
          template = {
            annotation_convention = "emmylua", -- for a full list of annotation_conventions, see supported-languages below,
          },
        },
        python = {
          template = {
            annotation_convention = "reST", -- for a full list of annotation_conventions, see supported-languages below,
          },
        },
      },
    }
  end,
  -- Uncomment next line if you want to follow only stable versions
  version = "*",
}
