vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightOnYank", { clear = true }),
    callback = function()
        vim.highlight.on_yank { higroup = "Comment", timeout = 150 }
    end,
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
local M = {}


M.format_on_save = function(client, bufnr)
    local view
    if client.supports_method "textDocument/formatting" then
        vim.api.nvim_clear_autocmds {
            group = augroup,
            buffer = bufnr,
        }
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                view = vim.fn.winsaveview()
                vim.lsp.buf.format()
                vim.diagnostic.disable(bufnr)
            end,
        })
        vim.api.nvim_create_autocmd("BufWritePost", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.fn.winrestview(view)
                vim.diagnostic.enable(bufnr)
            end,
        })
    end
end

return M
