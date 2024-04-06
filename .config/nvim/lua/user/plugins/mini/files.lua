local function setup()
	local files = require 'mini.files'
	files.setup({
		mappings = {
			close = '<Esc>',
			go_in_plus = '<CR>',
		},
		windows = {
			max_number = 3,
			width_focus = 30,
			width_preview = 20,
		},
	})

	vim.keymap.set('n', '<c-e>', function()
		if not files.close() then
			files.open()
		end
	end, { desc = 'Mini File [E]xplorer' })
end

return { setup = setup }
