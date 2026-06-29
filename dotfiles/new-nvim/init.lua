vim.pack.add({ "https://github.com/wnkz/monoglow.nvim" })
require("monoglow").setup({
    on_colors = function(colors)
        colors.glow = "#d27e99"
    end,
    on_highlights = function(hl, colors)
        hl.String = { fg = colors.lack }
        hl.NormalFloat = { link = "Normal" }
        hl.FloatBorder = { fg = colors.glow }
        hl.StatusLine = { bg = "#0a0a0a" }
        hl.StatusLineNC = { bg = "#0a0a0a" }
    end,
})
vim.cmd.colorscheme("monoglow-lack")

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

vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()
require("mini.align").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup()
require("mini.move").setup()
require("mini.notify").setup({
    content = {
        format = function(notif)
            return " " .. notif.msg .. " "
        end,
    },
    window = {
        max_width_share = 0.5,
        winblend = 0,
        config = function()
            local has_statusline = vim.o.laststatus > 0
            local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
            return { anchor = "SE", title = "", col = vim.o.columns, row = vim.o.lines - pad }
        end,
    },
})

vim.pack.add({ "https://github.com/esmuellert/codediff.nvim" })
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
        vim.keymap.set("n", "ghp", gitsigns.preview_hunk, { desc = "[G]itsigns [H]unk [P]review" })
        vim.keymap.set("n", "ghr", gitsigns.reset_hunk, { desc = "[G]itsigns [H]unk [R]eset" })
        vim.keymap.set("n", "ghs", gitsigns.select_hunk, { desc = "[G]itsigns [H]unk [S]elec" })
    end,
    signs = signs,
    signs_staged = signs,
})

vim.pack.add({ "https://github.com/catgoose/nvim-colorizer.lua" })
require("colorizer").setup({
    user_default_options = {
        mode = "virtualtext",
        names = false,
        virtualtext = "󰄮",
    },
})

vim.pack.add({ "https://github.com/folke/which-key.nvim" })
require("which-key").setup({ preset = "helix" })

vim.pack.add({
    "https://github.com/saghen/blink.lib",
    "https://github.com/saghen/blink.indent",
    "https://github.com/saghen/blink.cmp",
})
require("blink.indent").setup({
    scope = { enabled = false },
    static = {
        char = "┆",
        highlighs = { "NonText" },
    },
})

local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup()
