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
      gdscript = { "gdformat" },
      sh = { "shfmt" },
      yaml = { "yamlfix" },
      -- fish = { "fish_indent" },
    },
    formatters = {
      yamlfix = {
        env = {
          YAMLFIX_SEQUENCE_STYLE = "block_style",
          YAMLFIX_WHITELINES = "1",
        },
      },
      prettier = {
        prepend_args = { "--prose-wrap", "always" },
      },
    },
  },
}
