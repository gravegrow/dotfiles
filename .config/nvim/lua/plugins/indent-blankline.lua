return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPost",
  config = function()
    vim.g.indent_blankline_filetype_exclude = { "python", "norg", "gdscript" }
  end,
}
