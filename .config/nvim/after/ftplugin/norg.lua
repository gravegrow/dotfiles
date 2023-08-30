vim.opt_local.conceallevel = 3
vim.opt_local.spelllang = "en_us"
vim.opt_local.spell = true

vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.list = false

-- local ok, zenmode = pcall(require, "zen-mode")
-- if ok then
--   vim.api.nvim_create_autocmd("BufEnter", {
--     pattern = { "*.norg" },
--     group = vim.api.nvim_create_augroup("NorgZen", { clear = true }),
--     callback = function()
--       zenmode.toggle()
--     end,
--   })
-- end
