return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup()
    require('mini.align').setup()
    require('mini.comment').setup()
    require('mini.splitjoin').setup()
    require('mini.statusline').setup()
    require('mini.surround').setup()
  end
}
