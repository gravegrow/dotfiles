vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.clipboard = "unnamedplus"
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
vim.opt.winborder = "rounded"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.cursorline = true
vim.o.virtualedit = "block" -- Allow going past end of line in blockwise mode
vim.o.autoindent = true -- Use auto indent
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor
vim.opt.shortmess:append("I") -- Disable intro screen
vim.opt.cmdheight = 0
vim.opt.laststatus = 2
vim.opt.ignorecase = true
vim.opt.isfname:append("32,(,)")
vim.opt.conceallevel = 0
vim.o.complete = ".,w,b,kspell" -- Use less sources
vim.opt.completeopt = { "menuone", "noselect", "fuzzy" }
vim.o.completetimeout = 100 -- Limit sources delay
vim.opt.wildmode = { "noselect", "full" }
vim.opt.wildoptions = { "pum", "fuzzy" }
vim.opt.pumheight = 10
vim.opt.pummaxwidth = 40
vim.opt.termguicolors = true
