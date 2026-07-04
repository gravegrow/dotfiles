return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        init = function()
            vim.g.loaded_nvim_treesitter = 1
        end,
    },

    {
        "lewis6991/ts-install.nvim",
        -- OPTIONAL
        config = function()
            require("ts-install").setup({
                ensure_install = {
                    "lua",
                    "c",
                    "bash",
                    -- etc
                },
                auto_install = true,
            })
        end,
    },
}
