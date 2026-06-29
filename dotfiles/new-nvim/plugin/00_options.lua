vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.fillchars = { eob = " " }
vim.opt.fillchars:append("vert:┃,horiz:━,horizdown:┳,horizup:┻,verthoriz:╋,vertleft:┫,vertright:┣")
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- Define which helper symbols to show tab = "» "
vim.opt.list = true
vim.opt.cmdheight = 0
vim.opt.winborder = "rounded"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.cursorline = true
vim.o.pumheight = 10
vim.o.virtualedit = "block" -- Allow going past end of line in blockwise mode
vim.o.autoindent = true -- Use auto indent
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor
vim.opt.shortmess:append("I") -- Disable intro screen
vim.opt.laststatus = 3
vim.opt.ignorecase = true
vim.opt.isfname:append("32,(,)")
vim.opt.conceallevel = 0
