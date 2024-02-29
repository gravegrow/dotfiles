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
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        ['<leader>f'] = { name = '[F]find', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]theme', _ = 'which_key_ignore' },
        ['gp'] = { name = '[P]review', _ = 'which_key_ignore' },
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
        vim.keymap.set('n', 'gph', gitsigns.preview_hunk, { desc = '[G]itsigns [P]review [H]unk' })
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
}
