return {
    "lewis6991/hover.nvim",
    opts = {},
    config = function()
        require("hover").config({
            --- List of modules names to load as providers.
            --- @type (string|Hover.Config.Provider)[]
            providers = {
                "hover.providers.diagnostic",
                "hover.providers.lsp",
                "hover.providers.dap",
                "hover.providers.man",
                "hover.providers.dictionary",
            },
            -- Whether the contents of a currently open hover window should be moved
            -- to a :h preview-window when pressing the hover keymap.
            preview_window = false,
            title = true,
        })

        vim.keymap.set("n", "K", function()
            require("hover").open()
        end, { desc = "hover.nvim (open)" })

        vim.keymap.set("n", "gK", function()
            require("hover").enter()
        end, { desc = "hover.nvim (enter)" })

        vim.keymap.set("n", "<C-p>", function()
            require("hover").switch("previous")
        end, { desc = "hover.nvim (previous source)" })

        vim.keymap.set("n", "<C-n>", function()
            require("hover").switch("next")
        end, { desc = "hover.nvim (next source)" })
    end,
}
