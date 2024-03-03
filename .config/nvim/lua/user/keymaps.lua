vim.keymap.set({ 'n', 'v' }, '<c-s>', '<cmd>update<cr>', { desc = '[S]ave file' })
vim.keymap.set({ 'i' }, '<c-s>', '<c-o><cmd>update<cr>', { desc = '[S]ave file' })

vim.keymap.set('v', 'p', '"_dP', { desc = 'Paste and keep' })
vim.keymap.set('v', 'P', '"_dP', { desc = 'Paste and keep' })

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { desc = 'Unbind space' })

for _, key in ipairs({ 'd', 'u', 'o', 'i' }) do
  vim.keymap.set(
    'n',
    string.format('<c-%s>', key),
    string.format('<c-%s>zz', key),
    { desc = string.format('Center screen when moving with <C-%s>', key) }
  )
end

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'Show [D]iagnostic [D]isplay' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open [D]iagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('v', '<a-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<a-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

vim.keymap.set('v', '<', '<gv', { desc = 'Move selection right' })
vim.keymap.set('v', '>', '>gv', { desc = 'Move selection left' })

vim.keymap.set('n', 'gf', ':edit <cfile><cr>', { desc = 'Go to [F]ile under cursor, creating needed' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('on-highlight-yank', { clear = true }),
  callback = function() vim.highlight.on_yank({ higroup = 'Number' }) end,
})
