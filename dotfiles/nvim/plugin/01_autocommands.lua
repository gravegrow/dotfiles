local cursor_line_nr_hl
local rec_group = vim.api.nvim_create_augroup("macro-recording", { clear = true })
vim.api.nvim_create_autocmd("RecordingEnter", {
    desc = "Changes cursorline color when starting recording a macro",
    group = rec_group,
    callback = function()
        cursor_line_nr_hl = vim.api.nvim_get_hl(0, { name = "CursorLineNR" })
        vim.api.nvim_set_hl(0, "CursorLineNR", { fg = "#ff0000" })
    end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
    desc = "Restores cursorline color when starting recording a macro",
    group = rec_group,
    callback = function()
        vim.api.nvim_set_hl(0, "CursorLineNR", { fg = cursor_line_nr_hl.fg })
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = "CurSearch" })
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    desc = "Changes formatting options",
    group = vim.api.nvim_create_augroup("format-options", { clear = true }),
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
    end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
    desc = "Clear search highlight when moving cursor",
    group = vim.api.nvim_create_augroup("auto-hlsearch", { clear = true }),
    callback = function()
        if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
            vim.schedule(function()
                vim.cmd.nohlsearch()
            end)
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    desc = "Remove whitespaces",
    group = vim.api.nvim_create_augroup("clear-whitespaces", { clear = true }),
    pattern = "*",
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

vim.api.nvim_create_user_command("Grep", "silent! grep! <args> | copen", {
    nargs = "+",
    bang = true,
    complete = function(ArgLead, CmdLine, CursorPos)
        local args = vim.split(CmdLine, "%s+")
        if #args <= 2 or CursorPos < #CmdLine then
            return {}
        end
        return vim.fn.getcompletion(ArgLead, "file")
    end,
})
