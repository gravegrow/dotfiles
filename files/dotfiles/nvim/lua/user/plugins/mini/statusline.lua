local function setup()
	local diagnostic_levels = {
		{ name = "ERROR", sign = "" },
		{ name = "WARN", sign = "" },
		{ name = "INFO", sign = "" },
		{ name = "HINT", sign = "" },
	}

	local statusline = require "mini.statusline"

	local section_lsp = function()
		local buf_ft = vim.bo.filetype
		local clients = vim.lsp.get_clients()

		if next(clients) == nil then
			return ""
		end

		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return ""
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
			return ""
		end
		local counts = get_diagnostic_count()
		local severity, t = vim.diagnostic.severity, {}
		for _, level in ipairs(diagnostic_levels) do
			local n = counts[severity[level.name]] or 0
			if n > 0 then
				-- t[level.name] = string.format("%s %s", level.sign, n)
				t[level.name] = string.format("%s:%s", level.sign, n)
			end
		end

		if vim.tbl_count(t) == 0 then
			return ""
		end
		return t
	end

	local function GetModifiedBuffersColor()
		return vim.bo[0].modified and "StatusLineModified" or "StatusLineFill"
	end

	local function get_filetype_icon()
		local fileinfo = statusline.section_fileinfo({})
		return fileinfo:gmatch "([^ ]+)"() or ""
	end

	local section_filename = function(args)
		if vim.bo.buftype == "terminal" then
			return "%t"
		else
			local filename = vim.fn.fnamemodify(vim.fn.expand "%", ":t")
			return filename
		end
	end

	---@diagnostic disable-next-line
	statusline.setup({
		content = {
			active = function()
				local _, mode_hl = statusline.section_mode({ trunc_width = 120 })
				local git = vim.b.gitsigns_head and " " .. vim.b.gitsigns_head or ""
				local lsp = section_lsp()
				local diagnostics = section_diagnostics({ trunc_width = 75 })
				local filename = section_filename()

				return statusline.combine_groups({
					{ hl = mode_hl, strings = { "" } },
					{ hl = "StatusLine", strings = { lsp } },

					{ hl = "StatusError", strings = { diagnostics.ERROR } },
					{ hl = "StatusWarn", strings = { diagnostics.WARN } },
					{ hl = "StatusInfo", strings = { diagnostics.INFO } },
					{ hl = "StatusHint", strings = { diagnostics.HINT } },

					"%<", -- Mark general truncate point
					{ hl = GetModifiedBuffersColor(), strings = { get_filetype_icon(), filename } },
					"%=", -- End left alignment
					{ hl = "StatusLineFill", strings = { git } },
					{ hl = "Statusline", strings = { "%l:%L | %c" } },
					{ hl = mode_hl, strings = { "󰈚" } },
				})
			end,
		},
	})
end

return { setup = setup }
