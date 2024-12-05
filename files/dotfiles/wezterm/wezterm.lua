local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- config.font = wezterm.font_with_fallback({ 'Berkeley Mono Variable', 'JetBrainsMono Nerd Font Mono' })
-- config.line_height = 1.40

config.font = wezterm.font({ family = 'VictorMono Nerd Font Mono ', weight = 'Medium' })
config.line_height = 1.25

config.font_size = 17
config.window_close_confirmation = 'NeverPrompt'

config.window_padding = {
	top = config.font_size,
	bottom = config.font_size,
	left = '1cell',
	right = '1cell',
}

config.enable_tab_bar = false
config.cursor_blink_rate = 0

-- config.window_background_opacity = 0.98
config.color_scheme = 'not-rose-pine'
config.underline_thickness = '1px'
config.underline_position = '-3px'
config.strikethrough_position = '0.5cell'

config.max_fps = 120

local make_session_keymap = function(key, paths, header)
	return {
		key = key,
		mods = 'CTRL|SHIFT',
		action = wezterm.action.SpawnCommandInNewTab({
			args = { 'tmux', 'new-session', '-As', 'Sessions', '~/.config/scripts/tmux-sessionizer ' .. paths },
		}),
	}
end

config.keys = {
	make_session_keymap('i', '~/.config/dotfiles/files/dotfiles/'),
	make_session_keymap('n', '/media/storage/development/notes'),
	make_session_keymap('m', '/media/storage/development/maya'),
	make_session_keymap(
		'p',
		''
			.. '/media/storage/development/unity/projects/ '
			.. '/media/storage/development/cpp '
			.. '/media/storage/development/godot '
			.. '/media/storage/development/warcraft '
	),

	{ key = 'Enter', mods = 'ALT', action = wezterm.action.DisableDefaultAssignment },
	{ key = 'Tab', mods = 'CTRL', action = wezterm.action.DisableDefaultAssignment },
	{ key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.DisableDefaultAssignment },
}

wezterm.on('user-var-changed', function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == 'ZEN_MODE' then
		if value == 'on' then
			overrides.font_size = 12
			overrides.font = wezterm.font 'Berkeley Mono'
			overrides.line_height = 1
		else
			overrides.font = nil
			overrides.font_size = nil
			overrides.line_height = nil
		end
	end
	window:set_config_overrides(overrides)
end)

return config
