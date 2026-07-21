-- for some reason just exporting config table doesnt work

vim.lsp.config("roslyn_ls", {
    settings = {
        ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = false,
            dotnet_enable_tests_code_lens = false,
        },
        ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "openFiles",
            dotnet_compiler_diagnostics_scope = "openFiles",
        },
    },
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = false,
            },
        },
    },
})

return {}
