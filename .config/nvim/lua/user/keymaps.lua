vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { desc = 'Unbind space' })

vim.keymap.set({ 'n', 'v' }, '<c-s>', '<cmd>update<cr>', { desc = 'Save file if new changes' })
vim.keymap.set({ 'i' }, '<c-s>', '<c-o><cmd>update<cr>', { desc = 'Save file if new changes' })

vim.keymap.set('v', 'p', '"_dP', { desc = 'Paste without copying visual selection' })

vim.keymap.set('v', 'y', 'myy`y', { desc = 'Keep cursor position while Yanking' })
vim.keymap.set('v', 'Y', 'myY`y', { desc = 'Keep cursor position while Yanking' })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next [D]iagnostic message' })

vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'Show [D]iagnostic [D]isplay' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open [D]iagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('v', '<a-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<a-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

vim.keymap.set('v', '<', '<gv', { desc = 'Move selection right, keep visual selection' })
vim.keymap.set('v', '>', '>gv', { desc = 'Move selection left, keep visual selection' })

vim.keymap.set('n', 'gf', ':edit <cfile><cr>', { desc = '[G]o to [F]ile' })

vim.keymap.set({ 'n', 'v', 'x' }, 'q:', ':q', { desc = 'It was defenetly a typo and you are want to Quit' })

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('on-highlight-yank', { clear = true }),
	callback = function() vim.highlight.on_yank({ higroup = 'YankHighlight' }) end,
})

for _, key in ipairs({ 'd', 'u', 'o', 'i' }) do
	vim.keymap.set(
		'n',
		string.format('<c-%s>', key),
		string.format('<c-%s>zz', key),
		{ desc = string.format('Center screen when moving with <C-%s>', key) }
	)
end
