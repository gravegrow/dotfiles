return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  opts = {
    notification = {
      view = {
        stack_upwards = false,
      },
      window = {
        -- normal_hl = "Comment",
        -- border_hl = "Comment",
        -- border = "single",
        x_padding = 0,
        winblend = 100,
      },
    },
  },
}
