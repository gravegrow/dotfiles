return {
	'tpope/vim-sleuth',

	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		config = function()
			require('which-key').setup()

			-- Document existing key chains
			require('which-key').register({
				['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
				['<leader>d'] = { name = '[D]iagnostic', _ = 'which_key_ignore' },
				['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
				['<leader>f'] = { name = '[F]find', _ = 'which_key_ignore' },
				['<leader>m'] = { name = '[M]aya', _ = 'which_key_ignore' },
				['<leader>n'] = { name = '[N]eorg', _ = 'which_key_ignore' },
				['gh'] = { name = '[H]unk', _ = 'which_key_ignore' },
			})
		end,
	},

	{
		'folke/todo-comments.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		event = 'VeryLazy',
		config = function()
			local todo = require 'todo-comments'
			todo.setup()
			vim.keymap.set('n', ']t', function()
				todo.jump_next()
			end, { desc = 'Next todo comment' })

			vim.keymap.set('n', '[t', function()
				todo.jump_prev()
			end, { desc = 'Previous todo comment' })
		end,
	},

	{
		'kyazdani42/nvim-web-devicons',
		event = 'VeryLazy',
		opts = { override = { gd = { icon = '' } } },
	},

	{
		'lewis6991/gitsigns.nvim',
		event = 'BufEnter',
		opts = {
			on_attach = function()
				local gitsigns = package.loaded.gitsigns
				vim.keymap.set('n', 'ghp', gitsigns.preview_hunk, { desc = '[G]itsigns [H]unk [P]review' })
				vim.keymap.set('n', 'ghr', gitsigns.reset_hunk, { desc = '[G]itsigns [H]unk [R]eset' })
			end,
			signs = {
				add = { text = '┃' },
				change = { text = '┃' },
				delete = { text = '━' },
				topdelete = { text = '━' },
				changedelete = { text = '~' },
				untracked = { text = '┆' },
			},
		},
	},

	{
		'nvim-treesitter/nvim-treesitter',
		event = 'BufEnter',
		build = ':TSUpdate',
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require('nvim-treesitter.configs').setup({
				ensure_installed = { 'bash', 'lua', 'markdown', 'vim', 'vimdoc' },
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	{
		'mbbill/undotree',
		event = 'VeryLazy',
		config = function()
			vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Open [U]ndotree' })
			vim.g.undotree_DiffAutoOpen = 0
		end,
	},

	{
		'folke/noice.nvim',
		event = 'VeryLazy',
		opts = {
			cmdline = { view = 'cmdline' },
			lsp = { signature = { enabled = false }, hover = { enabled = false } },
			messages = { enabled = true, view_search = false },

			routes = {
				{
					filter = { event = 'msg_showmode' },
					opts = { hl_group = 'MacroRecording' },
					view = 'virtualtext',
				},
			},
		},
		dependencies = { 'MunifTanjim/nui.nvim' },
	},

	{
		'NvChad/nvim-colorizer.lua',
		event = 'BufReadPost',
		config = function()
			require('colorizer').setup({
				user_default_options = {
					names = false,
					mode = 'virtualtext',
				},
			})
		end,
	},

	-- {
	-- 	'brenoprata10/nvim-highlight-colors',
	-- 	event = 'BufReadPost',
	-- 	opts = { render = 'virtual', virtual_symbol_position = 'eol', virtual_symbol = '●' },
	-- },

	{ 'Fymyte/rasi.vim', ft = 'rasi' },
	{ 'fladson/vim-kitty' },
}
