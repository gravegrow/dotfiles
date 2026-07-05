local keymap = vim.keymap.set

vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })
local fzf = require("fzf-lua")
fzf.setup({
    "telescope",
    defaults = {
        cwd_prompt = false,
        formatter = "path.filename_first",
    },
    winopts = { backdrop = 100 },
    lsp = {
        code_actions = {
            previewer = false,
            winopts = { height = 0.40, width = 0.80 },
        },
    },
    undotree = {
        winopts = {
            fullscreen = true,
            preview = {
                layout = "horizontal",
            },
        },
    },
})

fzf.register_ui_select()

keymap("n", "<leader>ff", function()
    fzf.files({ hidden = false })
end, { desc = "Files" })

keymap("n", "<leader>fF", function()
    fzf.files({ hidden = true })
end, { desc = "Files with Hidden" })

keymap("n", "<leader>fu", fzf.undotree, { desc = "Files with Hidden" })
