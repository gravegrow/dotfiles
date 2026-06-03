require("layouts.tilewide")

local monitor1 = "DP-2"
local monitor2 = "HDMI-A-1"

hl.monitor({
	output = monitor1,
	mode = "3440x1440@144",
	position = "0x0",
	scale = 1,
})

hl.monitor({
	output = monitor2,
	mode = "1920x1080@60",
	position = "3440x0",
	scale = 0.75,
})

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "usr-terminal"
local browser = "usr-browser"
local browser_private = "usr-browser-private"
local files_gui = "usr-files-gui"
local files_tui = "usr-files-tui"
local applauncher = "usr-applauncher"
local colopicker = "usr-colorpicker"

local MAIN_LAYOUT = "master"
-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd("eww open-many statusbar0 statusbar1")
	hl.exec_cmd("hyprpaper")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------
-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 0,
		gaps_out = 12,

		border_size = 2,

		col = {
			active_border = { colors = { "rgba(968d88FF)" } },
			inactive_border = "rgba(0a0a0aFF)",
		},

		allow_tearing = false,

		layout = MAIN_LAYOUT,
	},

	decoration = {
		rounding = 12,
		rounding_power = 2,
		blur = {
			enabled = false,
		},
		shadow = {
			enabled = false,
		},
	},

	animations = {
		enabled = false,
	},

	render = {
		cm_enabled = false,
	},

	cursor = {
		no_warps = true,
	},
})

hl.config({
	master = {
		new_status = "slave",
		mfact = 0.6,
	},
})

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us,ru",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:alt_space_toggle",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

local LEADER = "SUPER" -- Sets "Windows" key as main modifier

local Bind = {}

Bind.bind = function(keys, command)
	local sequence = LEADER
	for _, key in ipairs(keys) do
		sequence = sequence .. " + " .. key
	end
	return hl.bind(sequence, command)
end

Bind.run = function(keys, command)
	return Bind.bind(keys, hl.dsp.exec_cmd(command))
end

Bind.layout_msg = function(keys, msg)
	return Bind.bind(keys, hl.dsp.layout(msg))
end

Bind.bind({ LEADER, "SHIFT", "Q" }, hl.dsp.window.close())

Bind.bind({ LEADER, "SHIFT", "Space" }, hl.dsp.window.float({ action = "toggle" }))
Bind.bind({ LEADER, "mouse:274" }, hl.dsp.window.float({ action = "toggle" }))

Bind.run({ LEADER, "Space" }, applauncher)
Bind.run({ LEADER, "Return" }, terminal)
Bind.run({ LEADER, "E" }, files_tui)
Bind.run({ LEADER, "SHIFT", "E" }, files_gui)
Bind.run({ LEADER, "B" }, browser)
Bind.run({ LEADER, "SHIFT", "B" }, browser_private)
Bind.run({ LEADER, "C" }, colopicker)

Bind.layout_msg({ LEADER, "J" }, "cyclenext")
Bind.layout_msg({ LEADER, "K" }, "cycleprev")

-- Bind.layout_msg({ LEADER, "SHIFT", "J" }, "swapnext")
-- Bind.layout_msg({ LEADER, "SHIFT", "K" }, "swapprev")

Bind.layout_msg({ LEADER, "F" }, "focusmaster")
Bind.layout_msg({ LEADER, "SHIFT", "J" }, "swapwithmaster")

Bind.layout_msg({ LEADER, "H" }, "mfact -0.05")
Bind.layout_msg({ LEADER, "L" }, "mfact +0.05")

Bind.layout_msg({ LEADER, "I" }, "addmaster")
Bind.layout_msg({ LEADER, "D" }, "removemaster")

Bind.bind({ LEADER, "comma" }, function()
	hl.dispatch(hl.dsp.focus({ monitor = (hl.get_active_monitor().id - 1) % #hl.get_monitors() }))
end)

Bind.bind({ LEADER, "period" }, function()
	hl.dispatch(hl.dsp.focus({ monitor = (hl.get_active_monitor().id + 1) % #hl.get_monitors() }))
end)

Bind.bind({ LEADER, "SHIFT", "comma" }, function()
	hl.dispatch(hl.dsp.window.move({ monitor = (hl.get_active_monitor().id - 1) % #hl.get_monitors() }))
end)

Bind.bind({ LEADER, "SHIFT", "period" }, function()
	hl.dispatch(hl.dsp.window.move({ monitor = (hl.get_active_monitor().id + 1) % #hl.get_monitors() }))
end)

Bind.bind({ LEADER, "M" }, function()
	hl.workspace_rule({
		workspace = tostring(hl.get_active_workspace().id),
		layout = "monocle",
		no_border = true,
		no_rounding = false,
	})
end)

Bind.bind({ LEADER, "T" }, function()
	local workspace = hl.get_active_workspace()
	if workspace == nil then
		return
	end
	hl.workspace_rule({
		workspace = tostring(workspace.id),
		layout = MAIN_LAYOUT,
		no_border = #workspace:get_windows() == 1,
		no_rounding = true,
	})
end)

for _, event in pairs({ "window.open", "window.close", "window.destroy", "window.kill", "window.active" }) do
	hl.on(event, function(_)
		local workspace = hl.get_active_workspace()
		if workspace == nil then
			return
		end
		local show_border = #workspace:get_windows() == 1 or workspace.tiled_layout == "monocle"
		hl.workspace_rule({
			workspace = tostring(workspace.id),
			no_border = show_border,
			no_rounding = not show_border,
		})
	end)
end

local function swap_workspace(index)
	local id = hl.get_active_monitor().id
	index = id * 10 + index
	hl.dispatch(hl.dsp.focus({ workspace = index, on_current_monitor = true }))
end

local function move_to_workspace(index)
	local id = hl.get_active_monitor().id
	index = id * 10 + index
	hl.dispatch(hl.dsp.window.move({
		workspace = index,
		on_current_monitor = true,
		follow = false,
		-- layout = "master",
	}))
end

for i = 1, 10 do
	local key = i % 10
	hl.bind(LEADER .. " + " .. key, function()
		swap_workspace(key)
	end)
	hl.bind(LEADER .. " + SHIFT + " .. key, function()
		move_to_workspace(i)
	end)
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(LEADER .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(LEADER .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

for i = 1, 10 do
	hl.workspace_rule({ workspace = tostring(i), monitor = monitor1 })
	hl.workspace_rule({ workspace = tostring(i + 10), monitor = monitor2 })
end

hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.window_rule({
	name = "qBittorrent-workspace",
	monitor = 1,
	workspace = 15,
	match = { class = "org.qbittorrent.qBittorrent" },
})

hl.window_rule({
	name = "mpv-monitor",
	monitor = 0,
	match = { class = "mpv" },
})
