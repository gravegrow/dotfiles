return {
  'nvim-neorg/neorg',
  build = ':Neorg sync-parsers',
  ft = { 'norg' },
  cmd = 'Neorg',
  keys = { { '<leader>no', '<cmd>Neorg index<cr>' } },
  opts = {
    load = {
      ['core.defaults'] = {}, -- Loads default behaviour
      ['core.concealer'] = {
        config = {
          folds = false,
        },
      }, -- Adds pretty icons to your documents
      ['core.dirman'] = { -- Manages Neorg workspaces
        config = {
          default_workspace = 'notes',
          workspaces = {
            notes = '/media/storage/development/notes',
          },
        },
      },
      ['core.completion'] = { -- A wrapper to interface with several different completion engines.
        config = {
          engine = 'nvim-cmp',
        },
      },
    },
  },
}
