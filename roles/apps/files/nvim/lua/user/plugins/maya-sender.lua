return {
	-- dir = '/media/storage/development/maya/maya-sender.nvim',
	'gravegrow/maya-sender.nvim',
	ft = 'python',
	opts = { port = 5115 },
	config = function(_, opts)
		require('maya-sender').setup(opts)

		vim.keymap.set('n', '<leader>mm', '<cmd>MayaSendBuffer <cr>')
		vim.keymap.set('v', '<leader>mm', '<cmd>MayaSendSelection <cr>')
	end,
}
