require("layouts.tilewide")
local Bind = require("binds")
local utils = require("utils")

local MONITOR_01_NAME = "DP-2"
local MONITOR_02_NAME = "HDMI-A-1"

local setup = {}

setup.monitors = {
    {
        output = MONITOR_01_NAME,
        mode = "3440x1440@144",
        position = "0x0",
        scale = 1,
    },
    {
        output = MONITOR_02_NAME,
        mode = "1920x1080@60",
        position = "3440x0",
        scale = 0.75,
    },
}

for _, spec in ipairs(setup.monitors) do
    hl.monitor(spec)
end

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

hl.on("hyprland.start", function()
    hl.exec_cmd("eww open-many statusbar0 statusbar1")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Nordzy-cursors-white")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_SCALE_FACTOR", "1")

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

        border_size = 0,

        col = {
            active_border = { colors = { "rgba(d27e99FF)" } },
            inactive_border = "rgba(202020FF)",
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
    xwayland = {
        force_zero_scaling = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
        enable_swallow = true,
        swallow_regex = "^(kitty)$",
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
    },
})

---------------------
---- KEYBINDINGS ----
---------------------

local LEADER = "SUPER" -- Sets "Windows" key as main modifier

Bind.run({ LEADER, "Space" }, applauncher)
Bind.run({ LEADER, "Return" }, terminal)
Bind.run({ LEADER, "E" }, files_tui)
Bind.run({ LEADER, "SHIFT", "E" }, files_gui)
Bind.run({ LEADER, "B" }, browser)
Bind.run({ LEADER, "SHIFT", "B" }, browser_private)
Bind.run({ LEADER, "C" }, colopicker)

Bind.bind({ LEADER, "SHIFT", "Q" }, hl.dsp.window.close())
Bind.bind({ LEADER, "W" }, utils.toggle_statusbar)
Bind.bind({ LEADER, "SHIFT", "Space" }, utils.toggle_floating_centered)
Bind.bind({ LEADER, "mouse:274" }, utils.toggle_floating_centered)

Bind.bind({ LEADER, "SHIFT", "F" }, hl.dsp.window.fullscreen({ action = "toggle" }))

Bind.layout_msg({ LEADER, "J" }, "cyclenext")
Bind.layout_msg({ LEADER, "K" }, "cycleprev")

Bind.layout_msg({ LEADER, "F" }, "focusmaster")
Bind.layout_msg({ LEADER, "SHIFT", "J" }, "swapwithmaster")

Bind.layout_msg({ LEADER, "H" }, "mfact -0.05")
Bind.layout_msg({ LEADER, "L" }, "mfact +0.05")

Bind.layout_msg({ LEADER, "I" }, "incnmaster +1")
Bind.layout_msg({ LEADER, "D" }, "incnmaster -1")

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

Bind.bind({ LEADER, "T" }, utils.switch_layout(MAIN_LAYOUT))
Bind.bind({ LEADER, "M" }, utils.switch_layout("monocle"))

for i = 1, 10 do
    local key = i % 10
    Bind.bind({ LEADER, key }, utils.swap_workspace(key))
    Bind.bind({ LEADER, "SHIFT", key }, utils.move_to_workspace(i))
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
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("rmpc next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("rmpc togglepause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("rmpc togglepause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("rmpc prev"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

for i = 1, 10 do
    hl.workspace_rule({ workspace = tostring(i), monitor = MONITOR_01_NAME })
    hl.workspace_rule({ workspace = tostring(i + 10), monitor = MONITOR_02_NAME })
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

hl.window_rule({
    name = "start-floating",
    match = { class = "org.gnome.Calculator" },
    float = true,
})

hl.window_rule({
    name = "floating-tweaks",
    match = { float = true },
    center = true,
    border_size = 2,
    rounding = 11,
    border_color = "rgb(202020)",
})

hl.workspace_rule({
    workspace = "w[tv2-99]",
    border_size = 1,
    no_rounding = true,
})
