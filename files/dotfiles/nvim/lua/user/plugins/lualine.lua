return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local lualine = require "lualine"
		local colors = ROSE_PINE_COLORS

		local theme = {
			normal = {
				a = { fg = colors.base, bg = colors.rose, gui = "bold" },
				b = { fg = colors.text, bg = colors.overlay },
				c = { fg = colors.subtle, bg = colors.surface },
			},

			insert = { a = { fg = colors.base, bg = colors.iris, gui = "bold" } },
			visual = { a = { fg = colors.base, bg = colors.gold, gui = "bold" } },
			replace = { a = { fg = colors.base, bg = colors.love, gui = "bold" } },

			inactive = {
				a = { fg = colors.base, bg = colors.base },
				b = { fg = colors.base, bg = colors.base },
				c = { fg = colors.base, bg = colors.base },
			},
		}

		local mode_icon = function()
			return ""
		end

		local filetype_icon = {
			"filetype",
			icon_only = true,
			padding = { left = 1, right = -1 },
		}

		local width_cond = function()
			return vim.o.columns > 65
		end

		local utils = require "lualine.utils.utils"

		local lsp = {
			function()
				local msg = ""
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					if client.name ~= "ruff_lsp" then
						return client.name:gsub("_", "-")
					end
				end
				return msg
			end,
			padding = { left = 1, right = -1 },
			color = {
				fg = colors.text,
				gui = "bold",
			},
		}

		local loc_icon = function()
			return "󰈚"
		end

		local location = {
			function()
				return "%l:%L"
			end,
			color = { fg = colors.subtle, gui = "bold" },
		}

		local diagnostics = {
			"diagnostics",
			symbols = { error = " ", warn = " ", info = " ", hint = "󰰁 " },
		}

		local simple_extension = function(filetype, display_name)
			return {
				sections = {
					-- stylua: ignore
					lualine_a = { function() return display_name end, },
					lualine_b = { filetype_icon },
				},
				filetypes = { filetype },
			}
		end

		lualine.setup({
			options = {
				theme = theme,
				component_separators = "",
				section_separators = { left = "", right = "" },
			},

			sections = {
				lualine_a = { mode_icon },
				lualine_b = {
					lsp,
					filetype_icon,
					diagnostics,
				},
				lualine_c = { { "filename" } },
				lualine_x = { { "branch", icon = "", cond = width_cond } },
				lualine_y = { location },
				lualine_z = { loc_icon },
			},
			extensions = {
				"quickfix",
				simple_extension("harpoon", "Harpoon"),
				simple_extension("minifiles", "Minifiles"),
				simple_extension("TelescopePrompt", "Telescope"),
			},
		})
	end,
}
