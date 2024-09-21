return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.ai").setup()
		require("mini.align").setup()
		require("mini.surround").setup()
		require("mini.pairs").setup()
		require("user.plugins.mini.files").setup()

		require("mini.icons").setup()
		require("mini.statusline").setup()
	end,
}
