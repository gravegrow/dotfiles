return {
	'ThePrimeagen/harpoon',
	branch = 'harpoon2',
	dependencies = { 'nvim-lua/plenary.nvim' },
	opts = { settings = { save_on_toggle = true } },

	config = function(_, opts)
		local harpoon = require 'harpoon'

		harpoon:setup(opts)

		local toggle_opts = { title = ' Harpoon ', title_pos = 'center' }
		vim.keymap.set('n', '<leader>a', function()
			harpoon:list():add()
			local name = vim.fn.expand '%:t'
			vim.notify('"' .. name .. '" added to Harpoon list.')
		end, { desc = 'Harpoon [A]dd to list' })
		vim.keymap.set('n', '<leader>e', function()
			harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts)
		end, { desc = 'Harpoon [E]xplorer toggle' })

		vim.keymap.set('n', '<C-h>', function()
			harpoon:list():select(1)
		end)
		vim.keymap.set('n', '<C-j>', function()
			harpoon:list():select(2)
		end)
		vim.keymap.set('n', '<C-k>', function()
			harpoon:list():select(3)
		end)
		vim.keymap.set('n', '<C-l>', function()
			harpoon:list():select(4)
		end)

		vim.cmd 'autocmd Filetype harpoon setlocal cursorline'
	end,
}