vim.pack.add({ "https://github.com/wnkz/monoglow.nvim" })

require("monoglow").setup({
    on_colors = function(colors)
        colors.glow = "#d27e99"
    end,
    on_highlights = function(hl, colors)
        hl.String = { fg = "#708090" }
    end,
})

vim.cmd.colorscheme("monoglow-lack")

vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/romus204/tree-sitter-manager.nvim",
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

vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

require("mini.ai").setup()
require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()
require("mini.align").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup()
require("mini.move").setup()

vim.pack.add({ "https://github.com/lukas-reineke/indent-blankline.nvim" })
require("ibl").setup({ indent = { char = "┆" } })

vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
local signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "│" },
    untracked = { text = "┆" },
}

require("gitsigns").setup({
    on_attach = function()
        local gitsigns = package.loaded.gitsigns
        vim.keymap.set(
            "n",
            "ghp",
            gitsigns.preview_hunk,
            { desc = "[G]itsigns [H]unk [P]review" }
        )
        vim.keymap.set(
            "n",
            "ghr",
            gitsigns.reset_hunk,
            { desc = "[G]itsigns [H]unk [R]eset" }
        )
        vim.keymap.set(
            "n",
            "ghs",
            gitsigns.select_hunk,
            { desc = "[G]itsigns [H]unk [S]elec" }
        )
    end,
    signs = signs,
    signs_staged = signs,
})
