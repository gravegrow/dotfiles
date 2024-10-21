return {
	-- {
	-- 	"kevinhwang91/nvim-bqf",
	-- 	event = "FileType qf",
	-- 	opts = {
	-- 		preview = {
	-- 			winblend = 0,
	-- 			show_title = false,
	-- 			show_scroll_bar = false,
	-- 			win_height = 5,
	-- 		},
	-- 	},
	-- },

	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		---@module "quicker"
		---@type quicker.SetupOptions
		opts = {},
	},
}
