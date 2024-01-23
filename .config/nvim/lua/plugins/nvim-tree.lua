return {
    "nvim-tree/nvim-tree.lua",
    keys = { "<leader>e" },
    cmd = "NvimTreeToggle",
    opts = {
        sort_by = "case_sensitive",
        view = { adaptive_size = true },
        renderer = {
            group_empty = false,
            indent_width = 2,
            icons = { show = { git = false } },
            indent_markers = {
                enable = true,
                inline_arrows = true,
                icons = {
                    corner = "└",
                    edge = "│",
                    item = "│",
                    bottom = "─",
                    none = " ",
                },
            },
        },
        -- sync_root_with_cwd = false,
        -- respect_buf_cwd = false,
        update_cwd = true,
        filters = {},
        update_focused_file = {
            enable = true,
            update_cwd = true,
        },
    },
    config = function(_, opts)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("nvim-tree").setup(opts)
        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
    end,
}
