return {
	{
		'vhyrro/luarocks.nvim',
		priority = 1000,
		config = true,
		lazy = true,
	},
	{
		'nvim-neorg/neorg',
		dependencies = { 'luarocks.nvim' },
		version = '*',
		ft = 'norg',
		opts = {
			load = {
				['core.defaults'] = {},
				['core.completion'] = {
					config = { engine = 'nvim-cmp' },
				},
				['core.concealer'] = {
					config = {
						icon_preset = 'diamond',
						folds = false,
					},
				},
			},
		},
		config = function(_, opts)
			require('neorg').setup(opts)
			vim.keymap.set(
				'n',
				'<leader>nc',
				'<cmd>Neorg toggle-concealer<cr>',
				{ desc = '[N]eorg [C]oncealer toggle' }
			)
		end,
	},
}
