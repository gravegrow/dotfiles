return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable "make" == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				prompt_prefix = " ",
				selection_caret = "▌ ",
				sorting_strategy = "ascending",
				layout_strategy = "flex",
				path_display = { "filename_first" },
				results_title = "",
				preview_title = "",
				layout_config = {
					vertical = {
						prompt_position = "top",
						mirror = true,
						preview_height = 0.3,
					},
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
					},
				},
				file_ignore_patterns = { ".spl" },
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		local builtin = require "telescope.builtin"
		-- stylua: ignore
		local document_diagnostics = function() builtin.diagnostics({ bufnr = 0 }) end

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[H]elp" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[H]elp" })
		vim.keymap.set("n", "<leader>ft", builtin.highlights, { desc = "[T]heme Highlights" })
		vim.keymap.set("n", "<leader>fb", builtin.builtin, { desc = "[B]uiltins" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live [G]rep" })
		vim.keymap.set("n", "<leader>fd", document_diagnostics, { desc = "Document [D]iagnostics" })
		vim.keymap.set("n", "<leader>fD", builtin.diagnostics, { desc = "Workspace [D]iagnostics" })
		vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "[O]ld Files" })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

		vim.keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 0,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })
	end,
}
