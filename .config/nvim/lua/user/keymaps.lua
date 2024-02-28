vim.keymap.set({ "n", "v", }, "<c-s>", "<cmd>update<cr>", { desc = "[S]ave file" })
vim.keymap.set({ "i" }, "<c-s>", "<c-o><cmd>update<cr>", { desc = "[S]ave file" })

vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("v", "P", '"_dP')

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { desc = 'Unbind space'})
