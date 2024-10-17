return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		cmdline = { view = "cmdline" },
		popupmenu = { enabled = false },
		lsp = {
			signature = { enabled = false },
			hover = { enabled = false },
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
}
