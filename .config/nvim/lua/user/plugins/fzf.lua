return {
	'ibhagwan/fzf-lua',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
		'telescope',
		winopts = {
			border = 'single',
			fullscreen = true,
			preview = {
				horizontal = 'right:65%',
				vertical = 'down:45%',
				flip_columns = 90,
			},
		},
		files = {
			fd_opts = ' --color=never --type f --hidden --follow  --exclude .git --exclude {%s}',
			cwd_prompt = false,
			formatter = 'path.filename_first',
			actions = false,
		},
		fzf_opts = {
			['--layout'] = 'reverse',
			['--info'] = 'right',
		},
	},
	config = function(_, opts)
		local fzf = require 'fzf-lua'

		local exclude = '*.tscn,*.tres,*.png,*.glb,*.import,*.ttf,.git*,*.spl'
		opts.files.fd_opts = opts.files.fd_opts:format(exclude)

		fzf.setup(opts)

		vim.keymap.set('n', '<leader>ff', fzf.files, { desc = '[F]ind [F]iles' })
		vim.keymap.set('n', '<leader>fh', fzf.helptags, { desc = '[F]ind [H]elp' })
		vim.keymap.set('n', '<leader>fk', fzf.keymaps, { desc = '[F]ind [K]eymaps' })
		vim.keymap.set('n', '<leader>ft', fzf.highlights, { desc = '[F]ind [T]heme Highlights' })
		vim.keymap.set('n', '<leader>fb', fzf.builtin, { desc = '[F]ind [B]uiltins' })
		vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = '[F]ind live [G]rep' })
		vim.keymap.set('n', '<leader>fw', fzf.grep_cword, { desc = '[F]ind grep [W]ord' })
		vim.keymap.set('n', '<leader>fW', fzf.grep_cWORD, { desc = '[F]ind grep [W]ORD' })
		vim.keymap.set('n', '<leader>fd', fzf.diagnostics_workspace, { desc = '[F]ind [D]iagnostics' })
		vim.keymap.set('n', '<leader>fr', fzf.resume, { desc = '[F]ind [R]esume last result' })
		vim.keymap.set('n', '<leader>fo', fzf.oldfiles, { desc = '[F]ind [O]ld Files' })
		vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find existing buffers' })
		vim.keymap.set('n', '<leader>/', function()
			fzf.lgrep_curbuf({ winopts = { preview = { hidden = 'hidden' } } })
		end, { desc = '[/] Fuzzily search in current buffer' })
	end,
}
