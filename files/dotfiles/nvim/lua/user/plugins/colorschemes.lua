return {
	"rose-pine/neovim",
	lazy = false,
	priority = 1000,
	name = "rose-ine",
	config = function()
		require("rose-pine").setup({
			variant = "main",
			styles = { italic = false },
			palette = {
				main = {
					base = "#161617",
					surface = "#232325",
					overlay = "#29292e",
					subtle = "#7c7c83",
					muted = "#464646",
					text = "#9A8F8A",
					love = "#945B5B",
					gold = "#B7927B",
					rose = "#b6939c",
					pine = "#627691",
					foam = "#8EA4A2",
					iris = "#807e96",
					highlight_low = "#252527",
					highlight_med = "#2a2a2c",
					highlight_high = "#4a4950",
				},
			},
			groups = { border = "surface" },
			highlight_groups = {
				Comment = { fg = "muted", italic = true },
				FloatTitle = { bg = "overlay", fg = "text" },
				WinSeparator = { link = "FloatBorder" },
				TelescopeNormal = { bg = "surface" },
				TelescopeTitle = { link = "FloatTitle" },
				TelescopeSelection = { bg = "overlay", bold = true },
				TelescopePreviewNormal = { bg = "overlay" },
				TelescopePreviewBorder = { bg = "overlay", fg = "overlay" },
				TelescopePreviewTitle = { bg = "overlay", fg = "overlay" },
				MiniFilesBorderModified = { bg = "surface", fg = "gold" },
			},
		})

		vim.cmd.colorscheme "rose-pine"

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "undotree", "qf", "help" },
			group = vim.api.nvim_create_augroup("floating-window-style", { clear = true }),
			callback = function()
				vim.cmd "set winhighlight=Normal:NormalFloat"
			end,
		})
	end,
}
