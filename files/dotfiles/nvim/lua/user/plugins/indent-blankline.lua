return {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  enabled = false,
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    indent = { char = "┆" },
    scope = { enabled = false },
    exclude = { filetypes = { "undotree" } },
  },
}
