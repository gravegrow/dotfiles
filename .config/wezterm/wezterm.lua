local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font 'BerkeleyMono Nerd Font Mono'
config.font_size = 15
config.window_close_confirmation = 'NeverPrompt'

config.window_padding = {
	top = config.font_size,
	bottom = config.font_size,
	left = '1cell',
	right = '1cell',
}

config.enable_tab_bar = false
config.cursor_blink_rate = 0

config.color_scheme = 'tomorrow'
config.underline_thickness = '1px'
config.underline_position = '-2px'
config.strikethrough_position = '0.5cell'

config.keys = {
	{
		key = 'i',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.SpawnCommandInNewTab({
			args = {
				'tmux',
				'new-session',
				'-As',
				'Sessions',
				'~/.config/scripts/tmux-sessionizer',
			},
		}),
	},
	{
		key = 'n',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.SpawnCommandInNewTab({
			args = {
				'tmux',
				'new-session',
				'-As',
				'Sessions',
				'~/.config/scripts/tmux-sessionizer /media/storage/development/notes',
			},
		}),
	},
	{ key = 'Enter', mods = 'ALT', action = wezterm.action.DisableDefaultAssignment },
	{ key = 'p', mods = 'CTRL|SHIFT', action = wezterm.action.DisableDefaultAssignment },
}

return config
