return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.ai").setup()
		require("mini.align").setup()
		require("mini.pairs").setup()
		require("mini.splitjoin").setup()
		require("mini.surround").setup()

		require("mini.icons").setup()
		require("mini.icons").mock_nvim_web_devicons()

		require("user.plugins.mini.files").setup()
	end,
}
