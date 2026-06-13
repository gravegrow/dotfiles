return {
    {
        "wnkz/monoglow.nvim",
        lazy = false,
        priority = 1000,
        enabled = true,
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
}
