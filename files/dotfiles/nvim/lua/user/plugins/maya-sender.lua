return {
  "gravegrow/maya-sender.nvim",
  -- dir = "/media/storage/development/maya/maya-sender.nvim/",
  lazy = true,
  ft = "py",
  keys = {
    { "<leader>mm", "<cmd>MayaSendBuffer<cr>", mode = "n" },
    { "<leader>mm", "<cmd>MayaSendSelection<cr>", mode = "x" },
  },
  config = true,
}
