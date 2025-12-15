return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  opts = {
    notify_on_error = true,
    format_after_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      markdown = { "prettier" },
    },
  },
}
