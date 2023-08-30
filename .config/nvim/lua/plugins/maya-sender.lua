return {
  dir = "/media/storage/dev/maya/tools/maya-sender.nvim",
  ft = "python",
  config = function()
    vim.keymap.set("n", "<leader>mm", "<cmd>MayaSendBuffer <cr>")
    vim.keymap.set("v", "<leader>mm", "<cmd>MayaSendSelection <cr>")
  end,
}
