return {
    {
        "wnkz/monoglow.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("monoglow").setup({
                style = "lack",
                on_colors = function(colors)
                    colors.glow = "#D27E99"
                    colors.blue2 = "#7FB4CA"
                end,
            })
        end,
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
