local vscode = require("vscode")

local keymap = vim.keymap.set
keymap("n", "<leader>ca", function()
  vscode.call("keyboard-quickfix.openQuickFix")
end)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
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
          "c_sharp",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = false },
      })
    end,
  },

  {
    "echasnovski/mini.surround",
    config = true,
  },
}

require("lazy").setup(plugins, { change_detection = { notify = false }, ui = { backdrop = 100 } })
