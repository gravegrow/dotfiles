local wezterm = require "wezterm"
local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback({ "Berkeley Mono Nerd Font Mono", "JetBrainsMono Nerd Font Mono" })
config.line_height = 1.63
config.font_size = 18

-- config.font = wezterm.font({ family = "VictorMono Nerd Font Mono ", weight = "Medium" })
-- config.line_height = 1.35
-- config.font_size = 18.5

config.window_close_confirmation = "NeverPrompt"
-- config.front_end = "WebGpu"

config.enable_tab_bar = false
config.cursor_blink_rate = 0

config.color_scheme = "daily"
config.underline_thickness = "1px"
config.underline_position = "-3px"
config.strikethrough_position = "0.5cell"

config.max_fps = 120

local make_session_keymap = function(key, paths, header)
    return {
        key = key,
        mods = "CTRL|SHIFT",
        action = wezterm.action.SpawnCommandInNewTab({
            args = { "tmux", "new-session", "-As", "Sessions", "~/.config/scripts/tmux-sessionizer " .. paths },
        }),
    }
end

config.keys = {
    make_session_keymap("i", "~/.config/dotfiles/files/dotfiles/"),
    make_session_keymap("n", "/media/storage/development/notes"),
    make_session_keymap("m", "/media/storage/development/maya"),
    make_session_keymap("u", "/media/storage/development/unity/projects/"),
    make_session_keymap(
        "p",
        ""
            .. "/media/storage/development/projects "
            .. "/media/storage/development/unity/projects/ "
            .. "/media/storage/development/cpp "
            .. "/media/storage/development/godot "
            .. "/media/storage/development/warcraft "
    ),

    { key = "Enter", mods = "ALT", action = wezterm.action.DisableDefaultAssignment },
    { key = "Tab", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
    { key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
}

return config
