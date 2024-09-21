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
      require("which-key").setup()
      require("which-key").add({
          { "<leader>c", group = "[C]ode" },
          { "<leader>d", group = "[D]iagnostic" },
          { "<leader>r", group = "[R]ename" },
          { "<leader>f", group = "[F]find" },
          { "<leader>m", group = "[M]aya" },
          { "<leader>n", group = "[N]eorg" },
          { "gh", group = "[H]unk" },
      })
  end,
}
