return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
        on_attach = function()
            local gitsigns = package.loaded.gitsigns
            vim.keymap.set("n", "ghp", gitsigns.preview_hunk, { desc = "[G]itsigns [H]unk [P]review" })
            vim.keymap.set("n", "ghr", gitsigns.reset_hunk, { desc = "[G]itsigns [H]unk [R]eset" })
            vim.keymap.set("n", "ghs", gitsigns.select_hunk, { desc = "[G]itsigns [H]unk [S]elec" })
        end,
        signs = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "" },
            topdelete = { text = "" },
            changedelete = { text = "│" },
            untracked = { text = "┆" },
        },
        signs_staged = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "" },
            topdelete = { text = "" },
            changedelete = { text = "│" },
            untracked = { text = "┆" },
        },
    },
}
