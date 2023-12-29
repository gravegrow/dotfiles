return {
  "nvim-treesitter/nvim-treesitter",
  cmd = "TSUpdate",
  event = "BufReadPre",
  opts = {
    ensure_installed = {
      "lua",
      "python",
      "c_sharp",
      "vim",
      "vimdoc",
      "c",
      "json",
      "fish",
      "gdscript",
    },
    highlight = {
      enable = true,
      use_languagetree = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
  --[[ dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/playground",
  }, ]]
}
