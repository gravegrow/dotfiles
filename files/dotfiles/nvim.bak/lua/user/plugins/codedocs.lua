return {
  "jeangiraldoo/codedocs.nvim",
  config = function()
    local codedocs = require("codedocs")
    codedocs.setup({
      default_styles = { python = "Numpy" },
    })
    vim.keymap.set("n", "<leader>cd", codedocs.insert_docs, { desc = "Inserts a [D]ocstring" })
  end,
}
