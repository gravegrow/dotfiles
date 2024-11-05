return {
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-context",
      config = function()
        require("treesitter-context").setup({ max_lines = 1 })
      end,
    },
  },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "lua",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "python",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = false },
    })
  end,
}
