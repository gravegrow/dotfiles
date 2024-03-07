return {
  'tpope/vim-sleuth',

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register({
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]iagnostic', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>f'] = { name = '[F]find', _ = 'which_key_ignore' },
        ['gh'] = { name = '[H]unk', _ = 'which_key_ignore' },
      })
    end,
  },

  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },

  {
    'kyazdani42/nvim-web-devicons',
    opts = { override = { gd = { icon = '' } } },
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function()
        local gitsigns = package.loaded.gitsigns
        vim.keymap.set('n', 'ghp', gitsigns.preview_hunk, { desc = '[G]itsigns [H]unk [P]review' })
        vim.keymap.set('n', 'ghr', gitsigns.reset_hunk, { desc = '[G]itsigns [H]unk [R]eset' })
      end,
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'bash', 'lua', 'markdown', 'vim', 'vimdoc' },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Open [U]ndotree' })
      vim.g.undotree_DiffAutoOpen = 0
    end,
  },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },

    opts = { settings = { save_on_toggle = true } },

    config = function(_, opts)
      local harpoon = require 'harpoon'

      harpoon:setup(opts)

      local toggle_opts = { title = ' Harpoon ', title_pos = 'center' }
      vim.keymap.set('n', '<leader>a', function() harpoon:list():append() end)
      vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts) end)

      vim.keymap.set('n', '<C-h>', function() harpoon:list():select(1) end)
      vim.keymap.set('n', '<C-j>', function() harpoon:list():select(2) end)
      vim.keymap.set('n', '<C-k>', function() harpoon:list():select(3) end)
      vim.keymap.set('n', '<C-l>', function() harpoon:list():select(4) end)

      vim.cmd 'autocmd Filetype harpoon setlocal cursorline'
    end,
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      cmdline = { view = 'cmdline' },
      lsp = { signature = { enabled = false }, hover = { enabled = false } },
      messages = { enabled = true, view_search = false },

      routes = {
        {
          filter = { event = 'msg_showmode' },
          opts = { hl_group = 'MacroRecording' },
          view = 'virtualtext',
        },
      },
    },
    dependencies = { 'MunifTanjim/nui.nvim' },
  },

  {
    'NvChad/nvim-colorizer.lua',
    event = 'BufReadPost',
    config = function()
      require('colorizer').setup({
        user_default_options = {
          names = false,
          mode = 'virtualtext',
        },
      })
    end,
  },

  { 'Fymyte/rasi.vim', ft = 'rasi' },
  { 'fladson/vim-kitty' },
}
