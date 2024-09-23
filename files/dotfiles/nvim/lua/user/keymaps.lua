local keymap = vim.keymap.set

keymap({ "n", "v" }, "<Space>", "<Nop>", { desc = "Unbind space" })

keymap({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })
keymap({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })

keymap("n", "<C-S>", "<Cmd>silent! update | redraw<CR>", { desc = "Save" })
keymap({ "i", "x" }, "<C-S>", "<Esc><Cmd>silent! update | redraw<CR>", { desc = "Save and go to Normal mode" })

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlighting after serch" })

keymap("x", "p", '"_dP', { desc = "Paste without copying visual selection" })

keymap("v", "y", "myy`y", { desc = "Keep cursor position while Yanking" })
keymap("v", "Y", "myY`y", { desc = "Keep cursor position while Yanking" })

keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous [D]iagnostic message" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next [D]iagnostic message" })

keymap("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show [D]iagnostic [D]isplay" })
keymap("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open [D]iagnostic [Q]uickfix list" })

keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

keymap("x", "<a-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("x", "<a-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

keymap("v", "<", "<gv", { desc = "Move selection right, keep visual selection" })
keymap("v", ">", ">gv", { desc = "Move selection left, keep visual selection" })

keymap("n", "gf", ":edit <cfile><cr>", { desc = "[G]o to [F]ile" })

for _, key in ipairs({ "d", "u", "o", "i" }) do
	keymap(
		"n",
		string.format("<c-%s>", key),
		string.format("<c-%s>zz", key),
		{ desc = string.format("Center screen when moving with <C-%s>", key) }
	)
end
