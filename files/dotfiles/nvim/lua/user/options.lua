vim.g.mapleader = " "

local opt = vim.opt

opt.undofile = true -- Enable persistent undo (see also `:h undodir`)
opt.swapfile = false -- Disable swap file

opt.backup = false -- Don't store backup while overwriting the file
opt.writebackup = false -- Don't store backup while overwriting the file

opt.mouse = "a" -- Enable mouse for all available modes

vim.cmd("filetype plugin indent on") -- Enable all filetype plugins

-- Appearance
opt.breakindent = true -- Indent wrapped lines to match line start
opt.cursorline = true -- Highlight current line
opt.linebreak = true -- Wrap long lines at 'breakat' (if 'wrap' is set)
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show line numbers
opt.splitbelow = true -- Horizontal splits will be below
opt.splitright = true -- Vertical splits will be to the right
opt.hlsearch = false

-- opt.colorcolumn = { 81 }

opt.ruler = false -- Don't show cursor position in command line
opt.showmode = false -- Don't show mode in command line
opt.wrap = false -- Display long lines as just one line

opt.signcolumn = "yes" -- Always show sign column (otherwise it will shift text)
opt.fillchars = { eob = " ", fold = "━" }
opt.fillchars:append("vert:┃,horiz:━,horizdown:┳,horizup:┻,verthoriz:╋,vertleft:┫,vertright:┣")

opt.listchars = { tab = "┆ ", trail = "·", nbsp = "␣" } -- Define which helper symbols to show tab = "» "
opt.list = true -- Define which helper symbols to show

opt.pumheight = 10 -- Make popup menu smaller
opt.laststatus = 3 -- Make statusline global
opt.cmdheight = 0 -- Cmdline height
opt.shortmess:append("I") -- Disable intro screen

-- Editing
opt.ignorecase = true -- Ignore case when searching (use `\C` to force not doing that)
opt.incsearch = true -- Show search results while typing
opt.infercase = true -- Infer letter cases for a richer built-in keyword completion
opt.smartcase = true -- Don't ignore case when searching if pattern has upper case
opt.smartindent = true -- Make indenting smart

opt.completeopt = "menuone,noinsert,noselect" -- Customize completions
opt.virtualedit = "block" -- Allow going past the end of line in visual block mode
opt.formatoptions = "qjl1" -- Don't autoformat comments

opt.tabstop = 2 -- A TAB character looks like N spaces
opt.expandtab = true -- If True pressing the TAB key will insert spaces instead of a TAB character
opt.softtabstop = 2 -- Number of spaces inserted instead of a TAB character
opt.shiftwidth = 2 -- Number of spaces inserted when indenting

opt.clipboard = "unnamedplus" --  Sync clipboard between OS and Neovim. See `:help 'clipboard'`
opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor

-- Decrease update time
vim.opt.updatetime = 60
vim.opt.timeoutlen = 250

-- Spellchecking
opt.spelllang = "en_us"
opt.spell = false

-- Autoformating
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  desc = "Changes formatting options",
  group = vim.api.nvim_create_augroup("on-formatopts", { clear = true }),
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Highlight opt. yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copt.ying) text",
  group = vim.api.nvim_create_augroup("on-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "WarningMsg" })
  end,
})

vim.api.nvim_create_autocmd("RecordingEnter", {
  desc = "Changes cursorline color when starting recording a macro",
  group = vim.api.nvim_create_augroup("on-recording-enter", { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, "CursorLine", { link = "CursorLineRecording" })
  end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  desc = "Restores cursorline color when starting recording a macro",
  group = vim.api.nvim_create_augroup("on-recording-leave", { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, "CursorLine", { link = "CursorLineDefault" })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.md",
  group = vim.api.nvim_create_augroup("create-on-save", { clear = true }),
  callback = function()
    local normalized = vim.fs.normalize(vim.fn.expand("%"))
    local is_file = vim.fn.filereadable(normalized) ~= 0

    if not is_file then
      vim.fn.mkdir(vim.fn.expand("%:h"), "p")
    end
  end,
})

vim.filetype.add({
  filename = {
    [".tmux"] = "tmux",
  },
})
