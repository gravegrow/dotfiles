return {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    opts = {
        definition = {
            -- width = 0.8,
        },
        symbol_in_winbar = {
            enable = false,
        },
        code_action = {
            keys = {
                quit = { "q", "<ESC>" },
            },
        },
        lightbulb = {
            enable_in_insert = false,
            sign = true,
            sign_priority = 40,
            virtual_text = false,
        },
        ui = {
            title = false,
            border = "single",
            code_action = "",
        },
    },
    config = function(_, opts)
        require("lspsaga").setup(opts)
        local keymap = vim.keymap.set

        keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
        keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
        keymap("n", "<leader>dd", "<cmd>Lspsaga show_line_diagnostics<CR>")
        keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")
        keymap({ "n", "t" }, "<A-i>", "<cmd>Lspsaga term_toggle<CR>")
    end,
}
