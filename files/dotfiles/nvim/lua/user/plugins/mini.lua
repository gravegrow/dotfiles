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

		require("mini.files").setup({
			mappings = {
				close = "<Esc>",
				go_in_plus = "<CR>",
			},
			windows = {
				max_number = 3,
				width_focus = 30,
				width_preview = 20,
			},
		})

		vim.keymap.set("n", "<c-e>", function()
			if not require("mini.files").close() then
				require("mini.files").open()
				require("mini.files").refresh({
					content = {
						filter = function(fs_entry)
							return not vim.startswith(fs_entry.name, "__py")
						end,
					},
				})
			end
		end, { desc = "Mini File [E]xplorer" })
	end,
}
