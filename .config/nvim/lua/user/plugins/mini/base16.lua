local setup = function()
	local palette = {
		base00 = '#141110',
		base01 = '#1C1917',
		base02 = '#25211E',
		base03 = '#302a27',
		base04 = '#544c45',
		base05 = '#9e9794',
		base06 = '#464646',
		base07 = '#8791A6',
		base08 = '#945B5B',
		base09 = '#B7927B',
		base0A = '#C4B28A',
		base0B = '#8A9A7B',
		base0C = '#8EA4A2',
		base0D = '#86A1BB',
		base0E = '#938AA9',
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

	-- palette.base05 = '#9e9794'
	-- palette.base07 = '#989FA4'
	-- palette.base09 = '#8D8580'
	-- palette.base0A = '#93736c'
	-- palette.base0B = '#868C91'
	-- palette.base0C = '#9CA4AA'
	-- palette.base0D = '#979FA3'
	-- palette.base0E = '#B4BDC3'

	local types = {
		keyword = palette.base08,
	}

	vim.cmd.hi 'clear'
	---@diagnostic disable-next-line
	require('mini.base16').setup({ palette = palette })

	local set_hl = function(name, opts)
		vim.api.nvim_set_hl(0, name, opts)
	end

	local highlights = {
		Normal = { bg = palette.base01 },
		NormalNC = { bg = palette.base01 },
		NormalSB = { bg = palette.base00 },
		Comment = { fg = palette.base06, italic = true },
		Whitespace = { fg = palette.base03 },
		CursorLine = { bg = palette.base02, bold = true },
		Visual = { bg = palette.base03, bold = true },
		CursorLineNR = { fg = palette.base0F, bold = true },
		LineNrAbove = { fg = palette.base04 },
		LineNrBelow = { fg = palette.base04 },
		LineNrSB = { bg = palette.base00, fg = palette.base04 },
		WinSeparator = { bg = palette.base01, fg = palette.base00 },
		StatusLineNC = { bg = palette.base00, fg = palette.base00 },
		StatusLine = { bg = palette.base00, fg = palette.base00 },
		PmenuThumb = { bg = palette.base09 },

		NormalFloat = { fg = palette.base05, bg = palette.base01 },
		FloatBorder = { fg = palette.base04 },
	}

	for h, v in pairs(highlights) do
		set_hl(h, v)
	end

	set_hl('@string', { italic = true, fg = palette.base0B })
	set_hl('@string.special.path', { italic = true, fg = palette.base09 })
	set_hl('@string.special.url', { link = '@string.special.path' })
	set_hl('@markup.strikethrough', { strikethrough = true })
	set_hl('@markup.underline', { underline = true })

	set_hl('@operator', { fg = palette.base09 })
	set_hl('@constant', { fg = palette.base09, bold = true })
	set_hl('@attribute', { fg = palette.base07, bold = false })
	set_hl('@property', { fg = palette.base0E })
	set_hl('@boolean', { fg = palette.base09, italic = true })
	set_hl('@number', { fg = palette.base09, italic = false })
	set_hl('@number.float', { link = '@number' })
	set_hl('@constructor', { fg = palette.base0A })

	set_hl('@variable', { fg = palette.base05 })
	set_hl('@variable.member', { fg = palette.base07 })
	set_hl('@variable.builtin', { fg = palette.base08 })
	set_hl('@variable.parameter', { fg = palette.base07 })

	set_hl('@keyword', { fg = types.keyword, bold = true })
	set_hl('@keyword.repeat', { fg = types.keyword, bold = true })
	set_hl('@keyword.operator', { fg = types.keyword, bold = true })
	set_hl('@keyword.return', { fg = types.keyword, bold = true })

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
	set_hl('NeorgHeading2', { fg = palette.base07 })
	set_hl('NeorgHeading3', { fg = palette.base0E })
	set_hl('NeorgHeading4', { fg = palette.base0A })
	set_hl('NeorgHeading5', { fg = palette.base0C })
	set_hl('NeorgHeading6', { fg = palette.base0F })

	set_hl('NeorgDone', { fg = palette.base0B })
	set_hl('NeorgPending', { fg = palette.base09 })
	set_hl('NeorgUndone', { fg = palette.base08 })
	set_hl('NeorgBold', { fg = palette.base04, bold = true })
	set_hl('NeorgStrikethrough', { strikethrough = true })
	set_hl('NeorgUnderlined', { underline = true })

	set_hl('NeorgMarkupVerbatim', { link = 'Comment' })

	-- Colors are for nested quotes
	set_hl('Blue', { fg = palette.base0D })
	set_hl('Yellow', { fg = palette.base09 })
	set_hl('Red', { fg = palette.base08 })
	set_hl('Green', { fg = palette.base0B })
	set_hl('Brown', { fg = palette.base0F })

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
