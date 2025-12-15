return {
    {
        "webhooked/kanso.nvim",
        lazy = false,
        priority = 1000,
        config = true,
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
