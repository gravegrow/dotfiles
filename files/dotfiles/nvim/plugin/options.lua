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
vim.opt.winborder = "single"
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

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copt.ying) text",
    group = vim.api.nvim_create_augroup("on-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = "WarningMsg" })
    end,
})

vim.api.nvim_create_autocmd("RecordingEnter", {
    desc = "Changes cursorline color when starting recording a macro",
    group = vim.api.nvim_create_augroup("MacroRecording", { clear = true }),
    callback = function()
        vim.api.nvim_set_hl(0, "CursorLine", { link = "CursorLineRecording" })
    end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
    desc = "Restores cursorline color when starting recording a macro",
    group = "MacroRecording",
    callback = function()
        vim.api.nvim_set_hl(0, "CursorLine", { link = "CursorLineDefault" })
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    desc = "Changes formatting options",
    group = vim.api.nvim_create_augroup("FormatOpts", { clear = true }),
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
    end,
})
