return {
	{
		"nvim-neorg/neorg",
		version = "*",
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
				-- ['core.highlights'] = {
				-- 	config = {
				-- 		highlights = {
				-- 			todo_items = {
				-- 				done = '+NeorgDone',
				-- 				undone = '+NeorgUndone',
				-- 				pending = '+NeorgPending',
				-- 			},
				-- 			markup = {
				-- 				bold = '+NeorgBold',
				-- 				underline = '+NeorgUnderlined',
				-- 				strikethrough = '+NeorgStrikethrough',
				-- 			},
				-- 			headings = {
				-- 				{ prefix = '+NeorgHeading1', title = '+NeorgHeading1' },
				-- 				{ prefix = '+NeorgHeading2', title = '+NeorgHeading2' },
				-- 				{ prefix = '+NeorgHeading3', title = '+NeorgHeading3' },
				-- 				{ prefix = '+NeorgHeading4', title = '+NeorgHeading4' },
				-- 				{ prefix = '+NeorgHeading5', title = '+NeorgHeading5' },
				-- 				{ prefix = '+NeorgHeading6', title = '+NeorgHeading6' },
				-- 			},
				-- 		},
				-- 	},
				-- },
			},
		},
		config = function(_, opts)
			require("neorg").setup(opts)
			vim.keymap.set("n", "<leader>nc", "<cmd>Neorg toggle-concealer<cr>", { desc = "[N]eorg [C]oncealer toggle" })
		end,
	},
}
