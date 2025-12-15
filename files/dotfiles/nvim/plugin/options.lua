vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.fillchars = { eob = " ", fold = "━" }
vim.opt.fillchars:append("vert:┃,horiz:━,horizdown:┳,horizup:┻,verthoriz:╋,vertleft:┫,vertright:┣")
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- Define which helper symbols to show tab = "» "
vim.opt.list = true
vim.opt.cmdheight = 0
vim.opt.winborder = "single"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.cursorline = true

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    desc = "Changes formatting options",
    group = vim.api.nvim_create_augroup("FormatOpts", { clear = true }),
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
    end,
})
