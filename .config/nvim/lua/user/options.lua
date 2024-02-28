vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- Fallback colorscheme
vim.cmd.colorscheme('habamax')

-- Make statusline global
vim.opt.laststatus = 3

-- Cmdline height
vim.opt.cmdheight = 0

-- Make relative line numbers default
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

--  Sync clipboard between OS and Neovim. See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Disable swap
vim.opt.swapfile = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See :help 'list'
--  and :help 'listchars'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Disable highlighting on search
vim.opt.hlsearch = false

-- Hide characters after at the end of a buffer
vim.opt.fillchars = { eob = " " }

-- Position on new splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- :help tabstop
vim.opt.tabstop = 4

-- Wrap words
vim.opt.wrap = true
vim.opt.linebreak = true
