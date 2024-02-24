return {
    { "nvim-lua/plenary.nvim", lazy = true },
    { "fladson/vim-kitty", },
    {
        "kyazdani42/nvim-web-devicons",
        lazy = true,
        opts = {
            override = {
                gd = {
                    icon = "",
                },
            },
        },
    },
}
