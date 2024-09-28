vim.api.nvim_create_autocmd("FileType", {
	pattern = { "undotree", "qf", "help" },
	group = vim.api.nvim_create_augroup("util-window-style", { clear = true }),
	callback = function()
		vim.cmd "set winhighlight=Normal:NormalFloat"
	end,
})

return {
	"rose-pine/neovim",
	lazy = false,
	priority = 1000,
	name = "rose-pine",
	config = function()
		-- stylua: ignore
		_G.ROSE_PINE_COLORS = {
			base           = "#161617",
			surface        = "#1f1f22",
			overlay        = "#272830",
			muted          = "#3c3c49",
			subtle         = "#525265",
			text           = "#9A8F8A",
			love           = "#945B5B",
			gold           = "#B7927B",
			rose           = "#be8c8c",
			pine           = "#627691",
			foam           = "#8EA4A2",
			iris           = "#807e96",
			highlight_low  = "#272830",
			highlight_med  = "#272830",
			highlight_high = "#4a4950",
		}

		require("rose-pine").setup({
			variant = "main",
			styles = { italic = false },
			palette = { main = ROSE_PINE_COLORS },
			groups = { border = "surface" },

			highlight_groups = {
				Comment = { italic = true },
				CursorLineNr = { fg = "love" },
				FloatTitle = { bg = "overlay", fg = "text" },
				WinSeparator = { link = "FloatBorder" },
				TelescopeNormal = { bg = "surface" },
				TelescopeTitle = { link = "FloatTitle" },
				TelescopeSelection = { bg = "overlay", bold = true },
				TelescopePreviewNormal = { bg = "overlay" },
				TelescopePreviewBorder = { bg = "overlay", fg = "overlay" },
				TelescopePreviewTitle = { bg = "overlay", fg = "overlay" },
				MiniFilesBorderModified = { bg = "surface", fg = "gold" },
				TreesitterContext = { link = "NormalFloat" },
				TreesitterContextLineNumber = { link = "NormalFloat" },
				BqfPreviewFloat = { link = "TelescopePreviewNormal" },
				BqfPreviewBorder = { link = "TelescopePreviewBorder" },
				QuickFixLine = { fg = "gold" },
				RenderMarkdownCode = { bg = "surface" },
				RenderMarkdownDash = { fg = "overlay" },
				-- CmpItemAbbr = { fg = "text" },
				PmenuSel = { bg = "overlay", bold = true },
				Search = { blend = 100, bg = "overlay", fg = "love" },
				CurSearch = { fg = "love", bg = "overlay", bold = true, underline = true },

				["@keyword.operator"] = { bold = true },
				["@type.builtin"] = { fg = "rose", italic = true },
				["@markup.italic"] = { italic = true },
				["@constructor.lua"] = { link = "@punctuation.bracket" },
			},
		})

		vim.cmd.colorscheme "rose-pine"
	end,
}
