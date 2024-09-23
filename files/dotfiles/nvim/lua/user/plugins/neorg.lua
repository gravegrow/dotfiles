return {
	"nvim-neorg/neorg",
	-- version = "*",
	ft = "norg",
	opts = {
		load = {
			["core.defaults"] = {},
			["core.completion"] = {
				config = { engine = "nvim-cmp" },
			},
			["core.concealer"] = {
				config = {
					folds = true,
					icons = {
						heading = {
							icons = { "󰎤", "󰎧", "󰎪", "󰎭", "󰎱", "󰎳" },
						},
					},
				},
			},
		},
	},
	config = function(_, opts)
		require("neorg").setup(opts)
		vim.keymap.set("n", "<leader>nc", "<cmd>Neorg toggle-concealer<cr>", { desc = "[N]eorg [C]oncealer toggle" })
	end,
}
