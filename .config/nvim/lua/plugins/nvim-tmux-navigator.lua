return {
    "alexghergh/nvim-tmux-navigation",
    keys = {
        "<C-h>",
        "<C-j>",
        "<C-k>",
        "<C-l>",
    },
    config = function()
        local tmux = require "nvim-tmux-navigation"

        vim.keymap.set("n", "<C-h>", tmux.NvimTmuxNavigateLeft)
        vim.keymap.set("n", "<C-j>", tmux.NvimTmuxNavigateDown)
        vim.keymap.set("n", "<C-k>", tmux.NvimTmuxNavigateUp)
        vim.keymap.set("n", "<C-l>", tmux.NvimTmuxNavigateRight)
    end,
}
