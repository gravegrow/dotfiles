return {
	{
		'echasnovski/mini.nvim',
		config = function()
			require('mini.ai').setup()
			require('mini.align').setup()
			require('mini.comment').setup()
			require('mini.splitjoin').setup()
			require('mini.surround').setup()

			require('user.plugins.mini.statusline').setup()
			require('user.plugins.mini.files').setup()
		end,
	},

	{
		'echasnovski/mini.base16',
		lazy = false,
		priority = 1000,
		config = function()
			require('user.plugins.mini.base16').setup()
		end,
	},
}
