local wezterm = require 'wezterm'
local action = wezterm.action
local M = {}

M.keys = {
	{
		key = 'i',
		mods = 'CTRL|SHIFT',
		action = action.SpawnCommandInNewTab({
			args = { 'tmux', 'new-session', '-s', 'TmuxSessionizer', '~/.config/scripts/tmux-sessionizer' },
		}),
	},
}

function M.setup(config) config.keys = M.keys end

return M
