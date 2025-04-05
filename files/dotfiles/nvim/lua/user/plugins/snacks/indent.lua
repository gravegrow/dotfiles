return {
  "snacks.nvim",
  opts = {
    indent = {
      indent = {
        priority = 1,
        enabled = true,
        char = "┆",
        only_scope = false,
        only_current = false,
        hl = "NonText",
      },
      scope = {
        enabled = true,
        char = "┆",
        hl = "Comment",
      },
      animate = { enabled = false },
    },
  },
}
