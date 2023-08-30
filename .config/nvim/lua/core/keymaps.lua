local options = { silent = true }
vim.keymap.set({ "n", "v", "i" }, "<c-s>", "<esc><cmd>w<cr>", options)

vim.keymap.set("v", "p", '"_dP', options)
vim.keymap.set("v", "P", '"_dP', options)

vim.keymap.set("v", "<", "<gv", options)
vim.keymap.set("v", ">", ">gv", options)

vim.keymap.set({ "i" }, "<S-Tab>", "<C-d>", options)
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", options)
vim.keymap.set("v", "K", "<Nop>", options)
vim.keymap.set("v", "J", "<Nop>", options)

vim.keymap.set("n", "<c-h>", "<c-w>h", options)
vim.keymap.set("n", "<c-j>", "<c-w>j", options)
vim.keymap.set("n", "<c-k>", "<c-w>k", options)
vim.keymap.set("n", "<c-l>", "<c-w>l", options)

vim.keymap.set("n", "<c-d>", "<c-d>zz", options)
vim.keymap.set("n", "<c-u>", "<c-u>zz", options)
vim.keymap.set("n", "<c-o>", "<c-o>zz", options)
vim.keymap.set("n", "<c-i>", "<c-i>zz", options)
vim.keymap.set("n", "G", "Gzz", options)

vim.keymap.set("n", "n", "nzzzv", options)
vim.keymap.set("n", "N", "Nzzzv", options)

vim.keymap.set("v", "<a-j>", ":m '>+1<CR>gv=gv", options)
vim.keymap.set("v", "<a-k>", ":m '<-2<CR>gv=gv", options)

vim.keymap.set("n", "J", "mzJ`z", options)

vim.keymap.set("n", "<leader>x", ":bd<cr>", options)

vim.keymap.set({ "n", "v" }, "<a-left>", "<cmd>vertical resize -10<cr>", options)
vim.keymap.set({ "n", "v" }, "<a-right>", "<cmd>vertical resize +10<cr>", options)
vim.keymap.set({ "n", "v" }, "<a-up>", "<cmd>resize -5<cr>", options)
vim.keymap.set({ "n", "v" }, "<a-down>", "<cmd>resize +5<cr>", options)

vim.keymap.set("n", "<a-[>", vim.diagnostic.goto_prev, options)
vim.keymap.set("n", "<a-]>", vim.diagnostic.goto_next, options)
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, options)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, options)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<a-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    -- vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
