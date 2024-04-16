local function setup()
	local diagnostic_levels = {
		{ name = 'ERROR', sign = '' },
		{ name = 'WARN', sign = '' },
		{ name = 'INFO', sign = '' },
		{ name = 'HINT', sign = '' },
	}

	local statusline = require 'mini.statusline'
	local devicons = require 'nvim-web-devicons'

	local section_lsp = function()
		local buf_ft = vim.bo.filetype
		local clients = vim.lsp.get_clients()

		if next(clients) == nil then
			return ''
		end

		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return ''
	end

	local get_diagnostic_count = function()
		local res = {}
		for _, d in ipairs(vim.diagnostic.get(0)) do
			res[d.severity] = (res[d.severity] or 0) + 1
		end
		return res
	end

	local section_diagnostics = function(args)
		local has_no_lsp_attached = #vim.lsp.get_clients() == 0
		local dont_show = statusline.is_truncated(args.trunc_width) or has_no_lsp_attached
		if dont_show then
			return ''
		end
		local counts = get_diagnostic_count()
		local severity, t = vim.diagnostic.severity, {}
		for _, level in ipairs(diagnostic_levels) do
			local n = counts[severity[level.name]] or 0
			if n > 0 then
				t[level.name] = string.format('%s %s', level.sign, n)
			end
		end

		if vim.tbl_count(t) == 0 then
			return ''
		end
		return t
	end

	local function GetModifiedBuffersCount()
		local count = 0
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.bo[buf].modified then
				count = count + 1
			end
		end

		if count == 0 then
			return ''
		end

		if count == 1 then
			return ' [+]'
		end

		return (' [%s]'):format(count)
	end

	local function get_filetype_icon()
		local icon, _ = devicons.get_icon_by_filetype(vim.bo.filetype) or '', nil
		icon = vim.bo.filetype == 'gdscript' and '' or icon
		return ' ' .. icon
	end

	local section_filename = function(args)
		if vim.bo.buftype == 'terminal' then
			return '%t'
		else
			local filename = vim.fn.fnamemodify(vim.fn.expand '%', ':t')
			return filename .. GetModifiedBuffersCount() .. get_filetype_icon()
		end
	end

	---@diagnostic disable-next-line
	statusline.setup({
		content = {
			active = function()
				local _, mode_hl = statusline.section_mode({ trunc_width = 120 })
				local git = vim.b.gitsigns_head and ' ' .. vim.b.gitsigns_head or ''
				local lsp = section_lsp()
				local diagnostics = section_diagnostics({ trunc_width = 75 })
				local filename = section_filename()

				return statusline.combine_groups({
					{ hl = mode_hl, strings = { '' } },
					{ hl = 'MiniStatusBlock', strings = { lsp } },

					{ hl = 'MiniStatusError', strings = { diagnostics.ERROR } },
					{ hl = 'MiniStatusWarn', strings = { diagnostics.WARN } },
					{ hl = 'MiniStatusInfo', strings = { diagnostics.INFO } },
					{ hl = 'MiniStatusHint', strings = { diagnostics.HINT } },

					'%<', -- Mark general truncate point
					{ hl = 'MiniStatuslineFilename', strings = { filename } },
					'%=', -- End left alignment
					{ hl = 'MiniStatuslineFilename', strings = { git } },
					{ hl = 'MiniStatusBlock', strings = { '%l:%L' } },
					{ hl = mode_hl, strings = { '󰈚' } },
				})
			end,
		},
	})
end

return { setup = setup }
