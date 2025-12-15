return {
    "seblyng/roslyn.nvim",
    ft = "cs",
    config = function()
        require("roslyn").setup()
        vim.lsp.config("roslyn", {
            settings = {
                ["csharp|completion"] = {
                    dotnet_show_completion_items_from_unimported_namespaces = true,
                    dotnet_show_name_completion_suggestions = true,
                },
                ["csharp|formatting"] = {
                    dotnet_organize_imports_on_format = true,
                },
            },
        })
    end,
}
