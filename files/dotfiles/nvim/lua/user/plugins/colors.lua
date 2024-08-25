return {
	{
		'echasnovski/mini.base16',
		lazy = false,
		priority = 1000,
		config = function()
			require('user.plugins.mini.base16').setup()
		end,
	},
	-- {
	-- 	'AlexvZyl/nordic.nvim',
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require('nordic').load()
	-- 	end,
	-- },
}
