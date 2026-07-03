require("vim._core.ui2").enable({})
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.termguicolors = true
local keymap = vim.keymap.set

------------------------------------
--           COLOSCHEME           --
------------------------------------

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

------------------------------------
--          CORE PLUGINS          --
------------------------------------

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

------------------------------------
--           MINI NVIM            --
------------------------------------

vim.pack.add({
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/antonk52/filepaths_ls.nvim",
})
vim.lsp.enable("filepaths_ls")

-- require("mini.completion").setup()
-- require("mini.cmdline").setup()
require("mini.pairs").setup()
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
            return {
                anchor = "SE",
                title = "",
                col = vim.o.columns,
                row = vim.o.lines - pad,
            }
        end,
    },
})

require("mini.files").setup({
    mappings = {
        close = "<ESC>",
        go_in = "L",
        go_in_plus = "l",
        go_out = "H",
        go_out_plus = "h",
    },
    content = {
        filter = function(fs_entry)
            return not vim.startswith(fs_entry.name, ".")
        end,
    },
})

keymap("n", "<C-E>", function(...)
    if not MiniFiles.close() then
        MiniFiles.open(...)
    end
end)

local show_dotfiles = false

local filter_show = function(_)
    return true
end

local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, ".")
end

local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide
    MiniFiles.refresh({ content = { filter = new_filter } })
end

vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
        local buf_id = args.data.buf_id
        keymap("n", "g.", toggle_dotfiles, { buffer = buf_id })
        keymap("n", "<CR>", function()
            require("mini.files").go_in({ close_on_file = true })
        end, { buffer = buf_id, desc = "Go in and close" })
    end,
})

------------------------------------
--          FILE PICKER           --
------------------------------------

vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })
local fzf = require("fzf-lua")
fzf.setup({
    "telescope",
    defaults = {
        cwd_prompt = false,
        formatter = "path.filename_first",
    },
    winopts = { backdrop = 100 },
})

keymap("n", "<leader>ff", fzf.files, { desc = "Files" })

------------------------------------
--          QOL PLUGINS           --
------------------------------------

vim.pack.add({
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/esmuellert/codediff.nvim",
})

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
        keymap("n", "ghp", gitsigns.preview_hunk, { desc = "Gitsigns Hunk Preview" })
        keymap("n", "ghr", gitsigns.reset_hunk, { desc = "Gitsigns Hunk Reset" })
        keymap("n", "ghs", gitsigns.select_hunk, { desc = "Gitsigns Hunk Select" })
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

vim.pack.add({ "https://github.com/saghen/blink.indent" })
require("blink.indent").setup({
    scope = { enabled = false },
    static = {
        char = "┆",
        highlighs = { "NonText" },
    },
})

vim.pack.add({ "https://github.com/y3owk1n/warp.nvim" })
local warp = require("warp")
warp.setup({ root_markers = {} })

for i, key in ipairs({ "H", "J", "K", "L" }) do
    keymap("n", "<C-" .. key .. ">", function()
        warp.goto_index(i)
    end)
end

keymap("n", "<leader>hw", warp.show_list, { desc = "Open Window" })
keymap("n", "<leader>ha", function()
    local name = vim.fs.basename(vim.api.nvim_buf_get_name(0))
    warp.add()
    vim.notify("Warp Add: " .. name, nil, { timeout_ms = 1000 })
end, { desc = "Add" })

vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("warp-mini-intergration", { clear = true }),
    pattern = { "MiniFilesActionRename", "MiniFilesActionMove" },
    callback = function(ev)
        local from, to = ev.data.from, ev.data.to
        local warp_exists

        warp_exists, warp = pcall(require, "warp")
        if warp_exists then
            warp.on_file_update(from, to)
        end
    end,
})

vim.pack.add({ "https://github.com/stevearc/quicker.nvim" })
require("quicker").setup()

vim.pack.add({ "https://github.com/folke/which-key.nvim" })
local whichkey = require("which-key")
whichkey.setup({
    preset = "helix",
})

whichkey.add({
    { "gh", group = "Gitsigns Hunk" },
    { "gr", group = "LSP Actions" },
    { "<leader>c", group = "Code" },
    { "<leader>r", group = "Rename" },
    { "<leader>h", group = "Warp" },
    { "<leader>d", group = "Diagnostics" },
    { "<leader>f", group = "FZF" },
})

----------------------------------
--         COMPLETIONS           --
----------------------------------

vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
    "https://github.com/rafamadriz/friendly-snippets",
    "https://github.com/xzbdmw/colorful-menu.nvim",
})

require("blink.cmp").setup({
    cmdline = {
        keymap = { preset = "inherit" },
        completion = {
            menu = { auto_show = true },
            list = {
                selection = {
                    preselect = false,
                },
            },
        },
    },
    signature = {
        enabled = true,
        window = { winhighlight = "FloatBorder:FloatBorder" },
    },
    completion = {
        accept = {
            auto_brackets = {
                enabled = false,
            },
        },
        menu = {
            border = "none",
            winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,BlinkCmpLabelMatch:Search",
            draw = {
                columns = { { "kind_icon" }, { "label", gap = 1 } },
                components = {
                    label = {
                        text = require("colorful-menu").blink_components_text,
                        highlight = require("colorful-menu").blink_components_highlight,
                    },
                },
            },
        },
        documentation = {
            auto_show = true,
            window = { winhighlight = "FloatBorder:FloatBorder" },
        },
        list = {
            selection = {
                preselect = false,
            },
        },
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
            buffer = {
                max_items = 3,
                min_keyword_length = 4,
            },
        },
    },
})

-- for _, plug in ipairs(vim.pack.get()) do
--     if not plug.active then
--         vim.pack.del({ plug.spec.name })
--     end
-- end
