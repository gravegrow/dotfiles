vim.pack.add({
    "https://github.com/romus204/tree-sitter-manager.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/stevearc/conform.nvim",
})

require("tree-sitter-manager").setup({
    auto_install = true,
})

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
    ensure_installed = {
        "lua_ls",
        "stylua",
        "vimls",
        "basedpyright",
        "ruff",
        "bashls",
        "roslyn_ls",
        "prettier",
        "shfmt",
    },
})

require("conform").setup({
    format_after_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
    formatters_by_ft = {
        lua = { "stylua" },
        markdown = { "prettier" },
        bash = { "shfmt" },
    },
})
