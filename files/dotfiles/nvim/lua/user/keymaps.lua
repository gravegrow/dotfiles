local keymap = vim.keymap.set

keymap({ "n", "v" }, "<Space>", "<Nop>", { desc = "Unbind space" })

keymap({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })
keymap({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlighting after search" })

keymap("x", "p", '"_dP', { desc = "Paste without copying visual selection" })
keymap({ "n", "x" }, "<leader>p", '"+P', { desc = "Paste from global keyboard" })

keymap({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank to global keyboard" })

keymap("v", "y", "myy`y", { desc = "Keep cursor position while Yanking" })
keymap("v", "Y", "myY`y", { desc = "Keep cursor position while Yanking" })

-- keymap("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show [D]iagnostic [D]isplay" })
keymap("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open [D]iagnostic [Q]uickfix list" })

keymap("n", "<leader>dd", function()
  vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = false })
  vim.api.nvim_create_autocmd("CursorMoved", {
    group = vim.api.nvim_create_augroup("line-diagnostics", { clear = true }),
    callback = function()
      vim.diagnostic.config({ virtual_lines = false, virtual_text = true })
      return true
    end,
  })
end, { desc = "Show [D]iagnostic [D]isplay" })

keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

keymap("x", "<a-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("x", "<a-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

keymap("v", "<", "<gv", { desc = "Move selection right, keep visual selection" })
keymap("v", ">", ">gv", { desc = "Move selection left, keep visual selection" })

keymap("n", "gf", ":edit <cfile><cr>", { desc = "[G]o to [F]ile" })

keymap("n", "<leader>;", "mmA;<ESC>`m", { desc = "Append semicolon" })

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
