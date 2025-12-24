vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspConfig", { clear = true }),
    callback = function(event)
        local keymap = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        keymap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        keymap("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")
        keymap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        keymap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
        keymap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        keymap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        keymap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        keymap("K", vim.lsp.buf.hover, "Hover Documentation")

        keymap("<leader>ci", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, "[C]ode [I]nlay Toggle")

        keymap("<leader>dd", function()
            local old_lines = vim.diagnostic.config().virtual_lines
            local old_text = vim.diagnostic.config().virtual_text
            vim.diagnostic.config({ virtual_lines = false, virtual_text = false })
            vim.diagnostic.open_float()
            vim.api.nvim_create_autocmd("CursorMoved", {
                group = "LspConfig",
                callback = function()
                    vim.diagnostic.config({
                        virtual_text = old_text,
                        virtual_lines = old_lines,
                    })
                    return true
                end,
            })
        end, "Show [D]iagnostic [D]isplay")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end,
})

vim.diagnostic.config({
    severity_sort = true,
    update_in_insert = false,
    float = { header = "" },
    virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
    signs = {
        text = {
            [vim.diagnostic.severity.WARN] = "󰬞",
            [vim.diagnostic.severity.ERROR] = "󰬌",
            [vim.diagnostic.severity.INFO] = "󰬐",
            [vim.diagnostic.severity.HINT] = "󰬏",
        },
    },
})
