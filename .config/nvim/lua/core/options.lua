local opt = vim.opt
local g = vim.g

vim.cmd.colorscheme "habamax"

opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 8

opt.hlsearch = false
opt.incsearch = true

-- Indenting
opt.autoindent = true
opt.expandtab = true
opt.smartindent = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes:1"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 450
opt.undofile = true
opt.swapfile = false
opt.updatetime = 500

vim.o.completeopt = "menu,menuone"

opt.cmdheight = 0

g.mapleader = " "
