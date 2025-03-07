return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function()
    require("which-key").setup({ preset = "classic" })
    require("which-key").add({
      { "<leader>d", group = "[D]iagnostic" },
      { "<leader>r", group = "[R]ename" },
      { "<leader>f", group = "[F]ind" },
      { "<leader>c", group = "[C]ode" },
      -- { "<leader>m", group = "[M]aya" },
      { "gh", group = "[H]unk" },
    })
  end,
}
