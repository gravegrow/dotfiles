local setup = function()
	local palette = {
		base00 = '#141110',
		base01 = '#1C1917',
		base02 = '#25211E',
		base03 = '#302a27',
		base04 = '#544c45',
		base05 = '#9e9794',
		base06 = '#555555',
		base07 = '#9ba0c0',
		base08 = '#af6a6a',
		base09 = '#b39580',
		base0A = '#b3a280',
		base0B = '#9cb380',
		base0C = '#97B7B3',
		base0D = '#809bb3',
		base0E = '#9c8aa8',
		base0F = '#a3685a',
	}

	local diagnostics = {
		Error = palette.base08,
		Warn = palette.base0F,
		Info = palette.base07,
		Information = palette.base07,
		Hint = palette.base0E,
		Ok = palette.base04,
	}

	local sets = {
		keyword = palette.base08,
	}

	vim.cmd.hi 'clear'
	---@diagnostic disable-next-line
	require('mini.base16').setup({ palette = palette })

	local set_hl = function(name, opts)
		vim.api.nvim_set_hl(0, name, opts)
	end

	set_hl('Normal', { bg = palette.base01 })
	set_hl('NormalNC', { bg = palette.base01 })
	set_hl('NormalSB', { bg = palette.base00 })
	set_hl('Comment', { fg = palette.base06, italic = true })
	set_hl('Whitespace', { fg = palette.base03 })
	set_hl('CursorLine', { bg = palette.base02, bold = true })
	set_hl('Visual', { bg = palette.base03, bold = true })
	set_hl('CursorLineNR', { fg = palette.base0F, bold = true })
	set_hl('LineNrAbove', { fg = palette.base04 })
	set_hl('LineNrBelow', { fg = palette.base04 })
	set_hl('LineNrSB', { bg = palette.base00, fg = palette.base04 })
	set_hl('WinSeparator', { bg = palette.base01, fg = palette.base00 })
	set_hl('StatusLineNC', { bg = palette.base00, fg = palette.base00 })
	set_hl('StatusLine', { bg = palette.base00, fg = palette.base00 })
	set_hl('PmenuThumb', { bg = palette.base09 })
	set_hl('Title', { bg = palette.base09, fg = palette.base00, bold = true })

	set_hl('NormalFloat', { fg = palette.base05, bg = palette.base01 })
	set_hl('FloatBorder', { fg = palette.base04 })

	set_hl('@string', { italic = true, fg = palette.base0B })
	set_hl('@string.special.path', { italic = true, fg = palette.base09 })
	set_hl('@string.special.url', { link = '@string.special.path' })
	set_hl('@markup.strikethrough', { strikethrough = true })
	set_hl('@markup.underline', { underline = true })

	set_hl('@operator', { fg = palette.base09 })
	set_hl('@constant', { fg = palette.base09, bold = true })
	set_hl('@attribute', { fg = palette.base0F, bold = false })
	set_hl('@property', { fg = palette.base0E })
	set_hl('@boolean', { fg = palette.base09, italic = true })
	set_hl('@number', { fg = palette.base09, italic = false })
	set_hl('@number.float', { link = '@number' })
	set_hl('@constructor', { fg = palette.base0A })

	set_hl('@variable', { fg = palette.base05 })
	set_hl('@variable.member', { fg = palette.base0E })
	set_hl('@variable.builtin', { fg = palette.base08 })
	set_hl('@variable.parameter', { fg = palette.base07 })

	set_hl('@keyword', { fg = sets.keyword, bold = true })
	set_hl('@keyword.repeat', { fg = sets.keyword, bold = true })
	set_hl('@keyword.operator', { fg = sets.keyword, bold = true })
	set_hl('@keyword.return', { fg = sets.keyword, bold = true })

	set_hl('@function.builtin', { fg = palette.base09 })
	set_hl('@function.parameter', { fg = palette.base0F, bold = true })

	set_hl('@type.builtin', { fg = palette.base0A })
	set_hl('@module.builtin', { fg = palette.base09 })

	set_hl('TelescopeSelection', { link = 'CursorLine' })
	set_hl('TelescopeMatching', { fg = palette.base0F, bold = true })
	set_hl('TelescopeBorder', { link = 'FloatBorder' })

	set_hl('CmpItemAbbrMatch', { fg = palette.base0F, bold = true })
	set_hl('CmpItemAbbrMatchFuzzy', { fg = palette.base0F, bold = true })
	set_hl('CmpItemAbbrDeprecated', { fg = palette.base06, strikethrough = true })
	set_hl('CmpItemAbbrDeprecatedDefault', { fg = palette.base06, strikethrough = true })

	set_hl('MiniStatusBlock', { fg = palette.base05, bg = palette.base02 })
	set_hl('MiniStatuslineFilename', { fg = palette.base04, bg = palette.base00 })
	set_hl('MiniStatuslineModeReplace', { fg = palette.base00, bg = palette.base08 })
	set_hl('MiniStatuslineModeNormal', { fg = palette.base00, bg = palette.base04 })
	set_hl('MiniFilesBorder', { link = 'FloatBorder' })
	set_hl('MiniFilesTitleFocused', { fg = palette.base07, bold = true })

	set_hl('YankHighlight', { fg = palette.base0F, bold = true })
	set_hl('MacroRecording', { fg = palette.base08, bold = true })

	set_hl('WhichKeyFloat', { bg = palette.base00 })
	set_hl('WhichKeySeparator', { bg = palette.base00, fg = palette.base0B })

	set_hl('Error', { fg = palette.base05 })
	set_hl('SpellBad', { italic = true, bold = true })

	set_hl('NeorgHeading1', { fg = palette.base0D })
	set_hl('NeorgHeading2', { fg = palette.base09 })
	set_hl('NeorgHeading3', { fg = palette.base07 })
	set_hl('NeorgHeading4', { fg = palette.base0A })
	set_hl('NeorgHeading5', { fg = palette.base0C })
	set_hl('NeorgHeading6', { fg = palette.base0F })

	set_hl('NeorgDone', { fg = palette.base0B })
	set_hl('NeorgPending', { fg = palette.base09 })
	set_hl('NeorgUndone', { fg = palette.base08 })
	set_hl('NeorgBold', { fg = palette.base08, bold = true })
	set_hl('NeorgStrikethrough', { strikethrough = true })
	set_hl('NeorgUnderlined', { underline = true })

	set_hl('LazyNormal', { bg = palette.base02 })
	set_hl('LazyBackdrop', { bg = palette.base01 })

	set_hl('FzfLuaBorder', { link = 'FloatBorder' })
	set_hl('FzfLuaTitle', { fg = palette.base00, bg = palette.base07, bold = true })
	set_hl('FzfLuaPreviewTitle', { fg = palette.base00, bg = palette.base09, bold = true })
	set_hl('FzfLuaCursorLine', { fg = palette.base00, bg = palette.base00 })

	local groups = { '', 'Sign', 'Floating', 'Underline', 'VirtualText' }
	for diag, color in pairs(diagnostics) do
		for _, grp in ipairs(groups) do
			local italic = (grp == 'VirtualText' or grp == 'Underline') and true or false
			local name = 'Diagnostic' .. grp .. diag
			set_hl(name, { fg = color, bg = nil, bold = true, italic = italic })
		end
		set_hl('MiniStatus' .. diag, { fg = diagnostics[diag], bg = palette.base02 })
	end

	local group = vim.api.nvim_create_augroup('colorscheme-apply', { clear = true })
	vim.api.nvim_create_autocmd('ColorSchemePre', {
		group = group,
		callback = function()
			vim.api.nvim_del_augroup_by_id(group)
		end,
	})

	local function set_whl()
		local win = vim.api.nvim_get_current_win()
		local whl = vim.split(vim.wo[win].winhighlight, ',')
		vim.list_extend(whl, {
			'Normal:NormalSB',
			'SignColumn:SignColumnSB',
			'LineNrAbove:LineNrSB',
			'LineNrBelow:LineNrSB',
		})

		whl = vim.tbl_filter(function(hl)
			return hl ~= ''
		end, whl)
		vim.opt_local.winhighlight = table.concat(whl, ',')
	end

	-- vim.api.nvim_create_autocmd('FileType', {
	-- 	group = group,
	-- 	pattern = { 'qf', 'help', 'undotree' },
	-- 	callback = set_whl,
	-- })
end

return { setup = setup }
