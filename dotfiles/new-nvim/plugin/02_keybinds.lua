local keymap = vim.keymap.set

keymap({ "n", "v" }, "<Space>", "<Nop>", { desc = "Unbind space" })
keymap({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })
keymap({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlighting after search" })
keymap("x", "p", "P", { desc = "Paste without copying visual selection" })
keymap({ "n", "x" }, "<leader>p", '"+P', { desc = "Paste from global clipboard" })
keymap({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank to global clipboard" })
keymap("v", "y", "myy`y", { desc = "Keep cursor position while Yanking" })
keymap("v", "Y", "myY`y", { desc = "Keep cursor position while Yanking" })
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
keymap("n", "gf", ":edit <cfile><cr>", { desc = "[G]o to [F]ile" })

keymap("i", "<C-y>", function()
    if vim.fn.pumvisible() ~= 0 then
        if vim.fn.complete_info().selected == -1 then
            return "<C-n><C-y>"
        else
            return "<C-y>"
        end
    else
        return "<C-y>"
    end
end, { expr = true, silent = true })

keymap("n", "<leader>q", function()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            qf_exists = true
        end
    end
    if qf_exists then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end, { desc = "Toggle Quickfix List" })

keymap("n", "<c-n>", function()
    local status = pcall(vim.cmd.cnext)
    if not status then
        pcall(vim.cmd.cfirst)
    end
end, { desc = "Next QF item" })

keymap("n", "<c-p>", function()
    local status = pcall(vim.cmd.cprev)
    if not status then
        pcall(vim.cmd.clast)
    end
end, { desc = "Prev QF item" })

for _, key in ipairs({ "d", "u", "o", "i" }) do
    keymap(
        "n",
        string.format("<c-%s>", key),
        string.format("<c-%s>zz", key),
        { desc = string.format("Center screen when moving with <C-%s>", key) }
    )
end
