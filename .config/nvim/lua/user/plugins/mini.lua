return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup()
    require('mini.align').setup()
    require('mini.comment').setup()
    require('mini.splitjoin').setup()
    require('mini.statusline').setup()
    require('mini.surround').setup()

    local files = require 'mini.files'
    files.setup({
      mappings = {
        close = '<Esc>',
        go_in_plus = '<CR>',
      },
      windows = {
        max_number = 3,
        width_focus = 30,
        width_preview = 20,
      },
    })

    vim.keymap.set('n', '<leader>e', function()
      if not files.close() then files.open() end
    end, { desc = 'Mini File [E]xplorer' })
  end,
}
