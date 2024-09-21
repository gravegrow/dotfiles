return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup()
		end,
	},
	event = "BufEnter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "bash", "lua", "markdown", "vim", "vimdoc", "markdown_inline" },
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
