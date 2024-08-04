return {
  dir = '/media/storage/development/godot/neovim/gut-runner.nvim',
  ft = 'gdscript',
  config = function()
    local gut = require 'gut-runner'
    gut.setup({
      godot = '/media/storage/software/godot/Godot_v4.2.1-stable_linux.x86_64',
    })

    vim.keymap.set('n', '<leader>gu', function() gut.run() end)
  end,
}
