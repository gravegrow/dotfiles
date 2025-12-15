return {
    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            user_default_options = {
                mode = "virtualtext",
                names = false,
                virtualtext = "󰄮",
            },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
}
