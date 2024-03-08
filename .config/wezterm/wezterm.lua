local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font 'BerkeleyMono Nerd Font Mono'
config.font_size = 15
config.window_close_confirmation = 'NeverPrompt'
config.window_padding = { bottom = 0 }
config.enable_tab_bar = false
config.cursor_blink_rate = 0

config.colors = {
	background = '#1C1917',
	foreground = '#9A8F8A',
	cursor_bg = '#837771',
	cursor_border = '#837771',
	cursor_fg = '#1C1917',
	ansi = {
		'#141110',
		'#af9da2',
		'#a1aba0',
		'#cfc5af',
		'#b3bfd1',
		'#e2d4df',
		'#b0c4c1',
		'#B4BDC3',
	},
	brights = {
		'#191515',
		'#af9da2',
		'#a1aba0',
		'#cfc5af',
		'#9aa4ac',
		'#e2d4df',
		'#b0c4c1',
		'#9A8F8A',
	},
}

config.keys = {
	{
		key = 'i',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.SpawnCommandInNewTab({
			args = { 'tmux', 'new-session', '-s', 'Sessions', '~/.config/scripts/tmux-sessionizer' },
		}),
	},
}

return config
