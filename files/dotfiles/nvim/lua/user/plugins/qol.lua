return {
	"tpope/vim-sleuth",

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup()
			require("which-key").add({
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>d", group = "[D]iagnostic" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>f", group = "[F]find" },
				{ "<leader>m", group = "[M]aya" },
				{ "<leader>n", group = "[N]eorg" },
				{ "gh", group = "[H]unk" },
			})
		end,
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		config = function()
			local todo = require "todo-comments"
			todo.setup()
			vim.keymap.set("n", "]t", function()
				todo.jump_next()
			end, { desc = "Next todo comment" })

			vim.keymap.set("n", "[t", function()
				todo.jump_prev()
			end, { desc = "Previous todo comment" })
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "BufEnter",
		opts = {
			on_attach = function()
				local gitsigns = package.loaded.gitsigns
				vim.keymap.set("n", "ghp", gitsigns.preview_hunk, { desc = "[G]itsigns [H]unk [P]review" })
				vim.keymap.set("n", "ghr", gitsigns.reset_hunk, { desc = "[G]itsigns [H]unk [R]eset" })
			end,
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "━" },
				topdelete = { text = "━" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-context",
				config = function()
					require("treesitter-context").setup({
						enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
						max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
						min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
						line_numbers = true,
						multiline_threshold = 20, -- Maximum number of lines to show for a single context
						trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
						mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
						-- Separator between context and content. Should be a single character string, like '-'.
						-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
						separator = "─",
						zindex = 20, -- The Z-index of the context window
						on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
					})
				end,
			},
		},
		event = "BufEnter",
		build = ":TSUpdate",
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "bash", "lua", "markdown", "vim", "vimdoc", "markdown_inline" },
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	{
		"mbbill/undotree",
		event = "VeryLazy",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Open [U]ndotree" })
			vim.g.undotree_DiffAutoOpen = 0
		end,
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			cmdline = { view = "cmdline" },
			lsp = { signature = { enabled = false }, hover = { enabled = false } },
			messages = { enabled = true, view_search = false },

			routes = {
				{
					filter = { event = "msg_showmode" },
					opts = { hl_group = "MacroRecording" },
					view = "virtualtext",
				},
			},
		},
		dependencies = { "MunifTanjim/nui.nvim" },
	},

	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPost",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					names = false,
					mode = "virtualtext",
				},
			})
		end,
	},
}
