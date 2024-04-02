return {
	{
		'vhyrro/luarocks.nvim',
		priority = 1000,
		config = true,
	},
	{
		'nvim-neorg/neorg',
		dependencies = { 'luarocks.nvim' },
		version = '*',
		opts = {
			load = {
				['core.defaults'] = {},
				['core.completion'] = {
					config = { engine = 'nvim-cmp' },
				},
				['core.concealer'] = {
					config = { icon_preset = 'diamond' },
				},
			},
		},
		config = function(_, opts)
			require('neorg').setup(opts)
		end,
	},
}
