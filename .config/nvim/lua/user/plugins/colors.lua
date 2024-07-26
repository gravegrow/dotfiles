return {
	-- {
	-- 	'vague2k/vague.nvim',
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require('vague').setup()
	-- 		vim.cmd.colorscheme 'vague'
	--
	-- 		local set_hl = function(name, opts)
	-- 			vim.api.nvim_set_hl(0, name, opts)
	-- 		end
	--
	-- 		set_hl('Normal', { bg = nil })
	-- 		set_hl('NormalNC', { bg = nil })
	-- 		set_hl('SignColumn', { bg = nil })
	--
	-- 		-- set_hl('MiniStatusBlock', { fg = palette.base05, bg = palette.base02 })
	-- 		-- set_hl('MiniStatuslineFilename', { fg = palette.base04, bg = palette.base00 })
	-- 		-- set_hl('MiniStatuslineModeReplace', { fg = palette.base00, bg = palette.base08 })
	-- 		-- set_hl('MiniStatuslineModeNormal', { fg = palette.base00, bg = palette.base04 })
	-- 		-- set_hl('MiniFilesBorder', { link = 'FloatBorder' })
	-- 		-- set_hl('MiniFilesTitleFocused', { fg = palette.base07, bold = true })
	-- 	end,
	-- },

	{
		'echasnovski/mini.base16',
		lazy = false,
		priority = 1000,
		config = function()
			require('user.plugins.mini.base16').setup()
		end,
	},
}
