return {
  dir = "/media/storage/development/neovim/plugins/pytest-runner.nvim",
  ft = "python",
  config = function()
    local pytest = require "pytest-runner"
    pytest.setup()
    vim.keymap.set("n", "<leader>t", function()
      pytest.run()
    end)
  end,
}
