return {
	{
		'vhyrro/luarocks.nvim',
		lazy = true,
		ft = 'neorg',
		opts = {
			rocks = { 'magick' },
		},
	},
	{
		'3rd/image.nvim',
		lazy = true,
		ft = 'neorg',
		dependencies = { 'luarocks.nvim' },
		config = function()
			require('image').setup()
		end,
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
						folds = true,
					},
				},
				['core.highlights'] = {
					config = {
						highlights = {
							todo_items = {
								done = '+NeorgDone',
								undone = '+NeorgUndone',
								pending = '+NeorgPending',
							},
							markup = {
								bold = '+NeorgBold',
							},
							headings = {
								{ prefix = '+NeorgHeading1', title = '+NeorgHeading1' },
								{ prefix = '+NeorgHeading2', title = '+NeorgHeading2' },
								{ prefix = '+NeorgHeading3', title = '+NeorgHeading3' },
								{ prefix = '+NeorgHeading4', title = '+NeorgHeading4' },
								{ prefix = '+NeorgHeading5', title = '+NeorgHeading5' },
								{ prefix = '+NeorgHeading6', title = '+NeorgHeading6' },
							},
						},
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
