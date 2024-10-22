return {
  "mbbill/undotree",
  lazy = true,
  keys = { {
    "<leader>u",
    "<cmd>lua vim.cmd.UndotreeToggle()<cr>",
    desc = "Open [U]ndotree",
  } },
  config = function()
    vim.g.undotree_DiffAutoOpen = 0
  end,
}
