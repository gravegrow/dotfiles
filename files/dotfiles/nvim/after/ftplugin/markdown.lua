vim.opt_local.spell = true

vim.opt_local.tabstop = 3
vim.opt_local.expandtab = true
vim.opt_local.softtabstop = 3
vim.opt_local.shiftwidth = 3

vim.opt_local.foldcolumn = "0" -- '0' is not bad
vim.opt_local.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt_local.foldlevelstart = 99
vim.opt_local.foldtext = ""

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
