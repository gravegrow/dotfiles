return {
	'folke/trouble.nvim',
	branch = 'dev',
	opts = {},
	config = function(_, opts)
		local trouble = require 'trouble'

		trouble.setup(opts)

		vim.keymap.set('n', '<leader>tt', '<cmd>Trouble diagnostics toggle<cr>', { desc = '[T]rouble [T]oggle' })
		vim.keymap.set('n', '<leader>tn', function()
			trouble.next({ jump = true })
		end, { desc = '[T]rouble [N]ext' })

		vim.keymap.set('n', '<leader>tp', function()
			trouble.prev({ jump = true })
		end, { desc = '[T]rouble [P]revious' })
	end,
}
