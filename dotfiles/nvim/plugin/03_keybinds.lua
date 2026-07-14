local keymap = vim.keymap.set

keymap({ "n", "x" }, "<Space>", "<Nop>", { desc = "Unbind space" })
keymap({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })
keymap({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlighting after search" })
keymap("x", "p", "P", { desc = "Paste without copying visual selection" })
keymap({ "n", "x" }, "<leader>p", '"+P', { desc = "Paste from global clipboard" })
keymap({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank to global clipboard" })
keymap("x", "y", "myy`y", { desc = "Keep cursor position while Yanking" })
keymap("x", "Y", "myY`y", { desc = "Keep cursor position while Yanking" })
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
keymap("n", "gf", ":edit <cfile><cr>", { desc = "Edit File" })

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

keymap("n", "<C-N>", function()
    local status = pcall(vim.cmd.cnext)
    if not status then
        pcall(vim.cmd.cfirst)
    end
end, { desc = "Next QF item" })

keymap("n", "<C-P>", function()
    local status = pcall(vim.cmd.cprev)
    if not status then
        pcall(vim.cmd.clast)
    end
end, { desc = "Prev QF item" })

for _, key in ipairs({ "o", "i" }) do
    keymap(
        "n",
        string.format("<c-%s>", key),
        string.format("<c-%s>zz", key),
        { desc = string.format("Center screen when moving with <C-%s>", key) }
    )
end

keymap("n", "<F12>", function()
    local inactive_plugs = vim.tbl_filter(function(plug)
        return not plug.active
    end, vim.pack.get())
    if #inactive_plugs == 0 then
        return vim.notify("No plugins to delete.")
    end
    local inactive_names = vim.tbl_map(function(plug)
        return plug.spec.name
    end, inactive_plugs)

    local msg = "Delete inactive plugin(s)?\n" .. table.concat(inactive_names, "\n")
    local choice = vim.fn.confirm(msg, "&Yes\n&No")

    if choice == 1 then
        vim.pack.del(inactive_names)
    end
end, { desc = "Delete Inacive Plugins" })
