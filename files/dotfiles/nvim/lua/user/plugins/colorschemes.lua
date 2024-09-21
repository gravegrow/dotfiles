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
					surface = "#252527",
					overlay = "#343332",
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
					highlight_med = "#45444b",
					highlight_high = "#585760",
				},
			},
			highlight_groups = {
				Comment = { fg = "muted", italic = true },
				TelescopeNormal = { bg = "surface" },
				TelescopeTitle = { bg = "overlay", fg = "text" },
				TelescopeBorder = { bg = "surface", fg = "surface" },
				TelescopeSelection = { bg = "overlay", bold = true },
				TelescopePreviewNormal = { bg = "overlay" },
				TelescopePreviewBorder = { bg = "overlay", fg = "overlay" },
				TelescopePreviewTitle = { bg = "overlay", fg = "overlay" },
			},
		})
		vim.cmd.colorscheme "rose-pine"
	end,
}
