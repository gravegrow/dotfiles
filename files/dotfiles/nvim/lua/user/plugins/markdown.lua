return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		opts = {
			heading = { left_pad = 1 },
			code = { left_pad = 1 },
		},
	},

	{
		"tadmccorkle/markdown.nvim",
		ft = "markdown",
		opts = {
			mappings = {
				link_follow = "<CR>",
			},

			on_attach = function(bufnr)
				local map = vim.keymap.set
				local opts = { buffer = bufnr }

				map({ "n", "i" }, "<M-CR>", "<Cmd>MDListItemBelow<CR>", opts)
				map({ "n", "x" }, "<leader>c", "<Cmd>MDTaskToggle<CR>", opts)

				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					group = vim.api.nvim_create_augroup("on-md-save", { clear = true }),
					callback = function()
						vim.cmd "MDResetListNumbering"
					end,
				})
			end,

			hooks = {
				follow_link = function(opts, fallback)
					if vim.startswith(opts.dest, "#") then
						fallback()
						return
					end

					if require("markdown.link").is_url(opts.dest) then
						fallback()
						return
					end

					local normalized = vim.fs.normalize(opts.dest)
					local is_file = vim.fn.filereadable(normalized) ~= 0
					local is_dir = vim.fn.isdirectory(normalized) ~= 0
					if is_file or is_dir then
						fallback()
						return
					end

					vim.api.nvim_command(":edit " .. opts.dest)
				end,
			},
		},
	},
}
