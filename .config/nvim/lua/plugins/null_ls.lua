local M = {}

M.ensure_installed = {
  "pylint",
  "black",
  "stylua",
  "isort",
  "fish",
  "csharpier",
  "prettier",
  "taplo",
  "astyle",
  "clang-format",
}

M.config = function()
  local mason_null_ls = require "mason-null-ls"
  local null_ls = require "null-ls"

  mason_null_ls.setup { ensure_installed = M.ensure_installed }

  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup {
    on_attach = require("core.commands").format_on_save,
    sources = {
      formatting.stylua,
      formatting.black.with { extra_args = { "--line-length", "100" } },

      diagnostics.fish,
      diagnostics.pylint.with {
        diagnostics_postprocess = function(diagnostic)
          diagnostic.code = diagnostic.message_id
        end,
        extra_args = { "--disable", "E" },
      },

      formatting.isort,

      formatting.csharpier,

      formatting.prettier,
      formatting.taplo,

      formatting.gdformat,
      -- diagnostics.gdlint,
      -- formatting.clang_format,
    },
  }
end

return {
  "jose-elias-alvarez/null-ls.nvim",
  event = "BufReadPre",
  config = M.config,
  dependencies = {
    "jay-babu/mason-null-ls.nvim",
  },
}
