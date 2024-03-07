-- print(vim.inspect(vim.treesitter.get_captures_at_cursor(0)))
local M = {}

M.plugin = {
	'catppuccin/nvim',
	name = 'catppuccin',
	lazy = false,
	priority = 1000,
	opts = {
		no_underline = true,
		styles = {
			comments = { 'italic' },
			conditionals = { 'italic' },
			loops = { 'bold' },
			functions = {},
			keywords = { 'bold' },
			strings = { 'italic' },
			variables = {},
			numbers = { 'bold' },
			booleans = { 'italic' },
			properties = {},
			types = {},
			operators = { 'bold' },
		},
		integrations = {
			mini = { enabled = true },
			mason = true,
		},
	},
	config = function(_, opts)
		opts.color_overrides = { all = M.dim_colors }
		opts.custom_highlights = M.custom_highlights

		require('catppuccin').setup(opts)
		vim.cmd.colorscheme 'catppuccin'

		M.special_cases()
	end,
}

M.custom_highlights = function(colors)
	local custom = {
		Constant = { fg = colors.text, bold = true },

		['@keyword.function'] = { bold = true },
		['@keyword.return'] = { bold = true },
		['@punctuation.bracket'] = { fg = colors.flamingo },
		['@variable.parameter'] = { italic = true },
		['@function.builtin'] = { fg = colors.sky, bold = true },

		FloatBorder = { fg = colors.mantle, bg = colors.mantle },
		FloatTitle = { fg = colors.mantle, bg = colors.rosewater, bold = true },
		NormalFloat = { bg = colors.mantle },

		NormalSB = { bg = colors.mantle },
		SignColumnSB = { bg = colors.mantle },

		CursorLine = { bold = true },
		CursorLineNr = { fg = colors.peach, bold = true },

		NormalNC = { bg = colors.base },
		Pmenu = { bg = colors.mantle },

		TelescopeNormal = { bg = colors.mantle },
		TelescopeTitle = { fg = colors.crust, bold = true },
		TelescopeSelection = { link = 'CursorLine' },

		TelescopePreviewNormal = { bg = colors.crust },
		TelescopePreviewBorder = { fg = colors.crust, bg = colors.crust },
		TelescopePreviewTitle = { bg = colors.lavender, fg = colors.base, bold = true },

		TelescopePromptBorder = { bg = colors.crust, fg = colors.crust },
		TelescopePromptNormal = { bg = colors.crust },
		TelescopePromptTitle = { fg = colors.crust, bg = colors.lavender, bold = true },

		CmpDoc = { bg = colors.crust },
		CmpDocBorder = { fg = colors.crust, bg = colors.crust },

		MiniStatusListIcon = { fg = colors.mantle, bg = colors.peach },
		MiniStatusBlock = { fg = colors.text, bg = colors.mantle, bold = false },
		MiniStatuslineFilename = { fg = colors.surface1, bg = colors.crust },
		MiniFilesTitle = { fg = colors.surface1, bg = colors.mantle },
		MiniFilesTitleFocused = { fg = colors.rosewater, bg = colors.mantle, bold = true },
		MiniStatuslineModeVisual = { bg = colors.green, fg = colors.mantle },

		GitSignsAddPreview = { bg = '#3B4439' },
		GitSignsDeletePreview = { bg = '#402120' },

		MacroRecording = { link = 'DiagnosticError' },
		YankHighlight = { link = 'DiagnosticWarn' },
	}
	return custom
end

function M.special_cases()
	local group = vim.api.nvim_create_augroup('colorscheme-apply', { clear = true })

	vim.api.nvim_create_autocmd('ColorSchemePre', {
		group = group,
		callback = function() vim.api.nvim_del_augroup_by_id(group) end,
	})

	local function set_whl()
		local win = vim.api.nvim_get_current_win()
		local whl = vim.split(vim.wo[win].winhighlight, ',')
		vim.list_extend(whl, { 'Normal:NormalSB', 'SignColumn:SignColumnSB' })
		whl = vim.tbl_filter(function(hl) return hl ~= '' end, whl)
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

	local colors = {
		Error = '#c76b77',
		Warn = '#b77e64',
		Info = '#88bed7',
		Hint = '#B279A7',
		Ok = '#6E6763',
	}

	local groups = { '', 'Sign', 'Floating', 'Underline', 'VirtualText' }
	local set_hl = function(name, opts) vim.api.nvim_set_hl(0, name, opts) end

	for diag, color in pairs(colors) do
		for _, grp in ipairs(groups) do
			local name = 'Diagnostic' .. grp .. diag
			set_hl(name, { fg = color, bg = nil, bold = true, italic = true })
		end
		set_hl('MiniStatus' .. diag, { fg = colors[diag], bg = colors.mantle })
	end
end

M.dim_colors = {
	base = '#1c1917',
	blue = '#b3bfd1',
	crust = '#141110',
	flamingo = '#837771',
	green = '#a1aba0',
	lavender = '#9CA4AA',
	mantle = '#191515',
	maroon = '#d4c4c7',
	mauve = '#B3BBC3',
	overlay0 = '#6E6763',
	overlay1 = '#7f849d',
	overlay2 = '#9CA4AA',
	peach = '#9a8f89',
	pink = '#e2d4df',
	red = '#af9da2',
	rosewater = '#c9b8b6',
	sapphire = '#9cb7c4',
	sky = '#B4BDC3',
	subtext0 = '#979FA4',
	subtext1 = '#bac2df',
	surface0 = '#2a2622',
	surface1 = '#302b27',
	surface2 = '#585b71',
	teal = '#b0c4c1',
	text = '#9CA4AA',
	yellow = '#cfc5af',
}

return M.plugin
