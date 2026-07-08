local keymap = vim.keymap.set

vim.pack.add({
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/esmuellert/codediff.nvim",
})

local signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "│" },
    untracked = { text = "┆" },
}

require("gitsigns").setup({
    on_attach = function()
        local gitsigns = package.loaded.gitsigns
        keymap("n", "ghp", gitsigns.preview_hunk, { desc = "Gitsigns Hunk Preview" })
        keymap("n", "ghr", gitsigns.reset_hunk, { desc = "Gitsigns Hunk Reset" })
        keymap("n", "ghs", gitsigns.select_hunk, { desc = "Gitsigns Hunk Select" })
    end,
    signs = signs,
    signs_staged = signs,
})

vim.pack.add({ "https://github.com/catgoose/nvim-colorizer.lua" })
require("colorizer").setup({
    user_default_options = {
        mode = "virtualtext",
        names = false,
        virtualtext = "󰄮",
    },
})

vim.pack.add({ "https://github.com/saghen/blink.indent" })
require("blink.indent").setup({
    scope = { enabled = false },
    static = {
        char = "┆",
        highlighs = { "NonText" },
    },
})

vim.pack.add({ "https://github.com/y3owk1n/warp.nvim" })
local warp = require("warp")
warp.setup({ root_markers = {} })

for i, key in ipairs({ "H", "J", "K", "L" }) do
    keymap("n", "<C-" .. key .. ">", function()
        warp.goto_index(i)
    end)
end

keymap("n", "<leader>hw", warp.show_list, { desc = "Open Window" })
keymap("n", "<leader>ha", function()
    local name = vim.fs.basename(vim.api.nvim_buf_get_name(0))
    warp.add()
    vim.notify("Warp Add: " .. name, nil, { timeout_ms = 1000 })
end, { desc = "Add" })

vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("warp-mini-intergration", { clear = true }),
    pattern = { "MiniFilesActionRename", "MiniFilesActionMove" },
    callback = function(ev)
        local from, to = ev.data.from, ev.data.to
        local warp_exists

        warp_exists, warp = pcall(require, "warp")
        if warp_exists then
            warp.on_file_update(from, to)
        end
    end,
})

vim.pack.add({ "https://github.com/stevearc/quicker.nvim" })
require("quicker").setup()

vim.pack.add({ "https://github.com/folke/which-key.nvim" })
local whichkey = require("which-key")
whichkey.setup({
    preset = "helix",
})

whichkey.add({
    { "gh", group = "Gitsigns Hunk" },
    { "gr", group = "LSP Actions" },
    { "<leader>c", group = "Code" },
    { "<leader>r", group = "Rename" },
    { "<leader>h", group = "Warp" },
    { "<leader>d", group = "Diagnostics" },
    { "<leader>f", group = "FZF" },
})

-- for _, plug in ipairs(vim.pack.get()) do
--     if not plug.active then
--         vim.pack.del({ plug.spec.name })
--     end
-- end
