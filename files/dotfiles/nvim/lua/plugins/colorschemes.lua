return {
    {
        "wnkz/monoglow.nvim",
        lazy = false,
        priority = 1000,
        config = true,
    },
    {
        "webhooked/kanso.nvim",
        lazy = false,
        priority = 1000,
        config = true,
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none",
                        },
                    },
                },
            },
        },
    },
    {
        "zenbones-theme/zenbones.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.zenbones_compat = 1
        end,
    },
}
