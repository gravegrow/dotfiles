local setup = function()
	local palette = {
		base00 = '#141110',
		base01 = '#1C1917',
		base02 = '#25211E',
		base03 = '#544c45',
		base04 = '#9A8F8A',
		base05 = '#a8a6a4',
		base06 = '#9da7af',
		base07 = '#a9c0d4',
		base08 = '#af6a6a',
		base09 = '#b39580',
		base0A = '#b3a280',
		base0B = '#9cb380',
		base0C = '#80b3aa',
		base0D = '#809bb3',
		base0E = '#8a94a8',
		base0F = '#a3685a',
	}

	local diagnostics = {
		Error = '#af6a6a',
		Warn = '#b77e64',
		Info = '#88bed7',
		Information = '#88bed7',
		Hint = '#B279A7',
		Ok = '#6E6763',
	}

	vim.cmd.hi 'clear'
	require('mini.base16').setup({ palette = palette })

	vim.api.nvim_set_hl(0, 'Normal', { bg = palette.base01 })
	vim.api.nvim_set_hl(0, 'NormalNC', { bg = palette.base01 })
	vim.api.nvim_set_hl(0, 'NormalSB', { bg = palette.base00 })
	vim.api.nvim_set_hl(0, 'SignColumn', { fg = palette.base03 })
	vim.api.nvim_set_hl(0, 'Comment', { fg = palette.base03 })
	vim.api.nvim_set_hl(0, 'Whitespace', { fg = palette.base02 })
	vim.api.nvim_set_hl(0, 'CursorLine', { bg = palette.base02, bold = true })

	vim.api.nvim_set_hl(0, '@string', { italic = true, fg = palette.base0B })
	vim.api.nvim_set_hl(0, '@string.special.path', { italic = true, fg = palette.base09 })

	vim.api.nvim_set_hl(0, '@operator', { fg = palette.base09 })

	vim.api.nvim_set_hl(0, '@variable', { fg = palette.base05 })
	vim.api.nvim_set_hl(0, '@variable.member', { fg = palette.base0D })
	vim.api.nvim_set_hl(0, '@variable.builtin', { fg = palette.base08 })

	vim.api.nvim_set_hl(0, '@keyword', { fg = palette.base0E, bold = true })
	vim.api.nvim_set_hl(0, '@keyword.return', { fg = palette.base0E, bold = true })

	vim.api.nvim_set_hl(0, '@boolean', { fg = palette.base09, italic = true })
	vim.api.nvim_set_hl(0, '@number', { fg = palette.base09, italic = true })

	vim.api.nvim_set_hl(0, '@function.builtin', { fg = palette.base09 })
	vim.api.nvim_set_hl(0, '@function.parameter', { fg = palette.base0F, bold = true })
	vim.api.nvim_set_hl(0, '@constructor', { fg = palette.base0A })

	vim.api.nvim_set_hl(0, '@type.builtin', { fg = palette.base0A, italic = true })
	vim.api.nvim_set_hl(0, '@property', { fg = palette.base0E })

	vim.api.nvim_set_hl(0, 'TelescopeSelection', { link = 'CursorLine' })

	local groups = { '', 'Sign', 'Floating', 'Underline', 'VirtualText' }
	local set_hl = function(name, opts)
		vim.api.nvim_set_hl(0, name, opts)
	end

	for diag, color in pairs(diagnostics) do
		for _, grp in ipairs(groups) do
			local italic = (grp == 'VirtualText' or grp == 'Underline') and true or false
			local name = 'Diagnostic' .. grp .. diag
			set_hl(name, { fg = color, bg = nil, bold = true, italic = italic })
		end
		set_hl('MiniStatus' .. diag, { fg = diagnostics[diag], bg = palette.base01 })
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
		vim.list_extend(whl, { 'Normal:NormalSB', 'SignColumn:SignColumnSB' })
		whl = vim.tbl_filter(function(hl)
			return hl ~= ''
		end, whl)
		vim.opt_local.winhighlight = table.concat(whl, ',')
	end

	vim.api.nvim_create_autocmd('FileType', {
		group = group,
		pattern = { 'qf', 'help', 'terminal', 'undotree' },
		callback = set_whl,
	})

	vim.api.nvim_create_autocmd('TermOpen', {
		group = group,
		callback = set_whl,
	})
end

return { setup = setup }
