pcall(require, 'luarocks.loader')
local gears = require('gears')
local awful = require('awful')
require('awful.autofocus')
local wibox = require('wibox')
local beautiful = require('beautiful')
local naughty = require('naughty')
local ruled = require('ruled')
local menubar = require('menubar')
local hotkeys_popup = require('awful.hotkeys_popup')
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require('awful.hotkeys_popup.keys')

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal(
	'request::display_error',
	function(message, startup)
		naughty.notification({
			urgency = 'critical',
			title = 'Oops, an error happened' .. (startup and ' during startup!' or '!'),
			message = message,
		})
	end
)
-- }}}

awful.spawn.once('dwm-autostart')

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. 'theme.lua')

-- This is used later as the default terminal and editor to run.

local mods = {
	SUPER = 'Mod4',
	SHIFT = 'Shift',
	CONTROL = 'Control',
}

local apps = {
	terminal = 'wezterm',
	launcher = 'rofi -modi drun,run -show drun',
	browser = 'dwm-browser',
	browser_private = 'dwm-browser-private',
	files_tui = 'dwm-files-tui',
	files_gui = 'dwm-files-gui',
	colorpicker = 'dwm-gpick',
	screengrab = 'dwm-screengrab',
	screenshot = 'dwm-screenshot',
}

-- {{{ Wallpaper
screen.connect_signal(
	'request::wallpaper',
	function(s)
		awful.wallpaper({
			screen = s,
			widget = {
				{
					image = beautiful.wallpaper,
					upscale = true,
					downscale = true,
					widget = wibox.widget.imagebox,
				},
				valign = 'center',
				halign = 'center',
				tiled = false,
				widget = wibox.container.tile,
			},
		})
	end
)
-- }}}

-- {{{ Wibar

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

screen.connect_signal('request::desktop_decoration', function(s)
	-- Each screen has its own tag table.
	awful.tag({ '1', '2', '3', '4', '5', '6', '7', '8', '9' }, s, awful.layout.suit.tile)

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()

	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox({
		screen = s,
		buttons = {
			awful.button({}, 1, function() awful.layout.inc(1) end),
			awful.button({}, 3, function() awful.layout.inc(-1) end),
			awful.button({}, 4, function() awful.layout.inc(-1) end),
			awful.button({}, 5, function() awful.layout.inc(1) end),
		},
	})

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.noempty,
		buttons = {
			awful.button({}, 1, function(t) t:view_only() end),
			awful.button({ mods.SUPER }, 1, function(t)
				if client.focus then
					client.focus:move_to_tag(t)
				end
			end),
			awful.button({}, 3, awful.tag.viewtoggle),
			awful.button({ mods.SUPER }, 3, function(t)
				if client.focus then
					client.focus:toggle_tag(t)
				end
			end),
			awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
			awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end),
		},
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = {
			awful.button({}, 1, function(c) c:activate({ context = 'tasklist', action = 'toggle_minimization' }) end),
			awful.button({}, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
			awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
			awful.button({}, 5, function() awful.client.focus.byidx(1) end),
		},
	})

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = 'top',
		screen = s,
		widget = {
			layout = wibox.layout.align.horizontal,
			{ -- Left widgets
				layout = wibox.layout.fixed.horizontal,
				mylauncher,
				s.mytaglist,
				s.mypromptbox,
			},
			s.mytasklist, -- Middle widget
			{ -- Right widgets
				layout = wibox.layout.fixed.horizontal,
				mykeyboardlayout,
				wibox.widget.systray(),
				mytextclock,
				s.mylayoutbox,
			},
		},
	})
end)

-- }}}

-- {{{ Key bindings

-- General Awesome keys
awful.keyboard.append_global_keybindings({
	awful.key({ mods.SUPER }, 'w', function() mouse.screen.sidebar.visible = not mouse.screen.sidebar.visible end),
	awful.key({ mods.SUPER, mods.CONTROL, mods.SHIFT }, 'r', awesome.restart),
	awful.key({ mods.SUPER }, 'Return', function() awful.spawn(apps.terminal) end),
	awful.key({ mods.SUPER }, 'b', function() awful.spawn(apps.browser) end),
	awful.key({ mods.SUPER }, 'e', function() awful.spawn(apps.files_tui) end),
	awful.key({ mods.SUPER, mods.SHIFT }, 'e', function() awful.spawn(apps.files_gui) end),
	awful.key({ mods.SUPER, mods.SHIFT }, 'b', function() awful.spawn(apps.browser_private) end),
	awful.key({ mods.SUPER }, 'p', function() awful.spawn(apps.screengrab) end),
	awful.key({ mods.SUPER }, 'c', function() awful.spawn(apps.colorpicker) end),
	awful.key({ mods.SUPER }, 'space', function() awful.spawn.with_shell(apps.launcher) end),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
	awful.key({ mods.SUPER }, 'j', function() awful.client.focus.byidx(1) end),
	awful.key({ mods.SUPER }, 'k', function() awful.client.focus.byidx(-1) end),
	awful.key({ mods.SUPER }, 'o', function() awful.screen.focus_relative(1) end),
	awful.key({ mods.SUPER, mods.SHIFT }, 'n', function()
		local c = awful.client.restore()
		if c then
			c:activate({ raise = true, context = 'key.unminimize' })
		end
	end),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
	awful.key({ mods.SUPER, mods.SHIFT }, 'j', function() awful.client.swap.byidx(1) end),
	awful.key({ mods.SUPER, mods.SHIFT }, 'k', function() awful.client.swap.byidx(-1) end),
	awful.key({ mods.SUPER }, 'u', awful.client.urgent.jumpto),
	awful.key({ mods.SUPER }, 'l', function() awful.tag.incmwfact(0.05) end),
	awful.key({ mods.SUPER }, 'h', function() awful.tag.incmwfact(-0.05) end),
	awful.key({ mods.SUPER }, 'i', function() awful.tag.incncol(1, nil, true) end),
	awful.key({ mods.SUPER }, 'd', function() awful.tag.incncol(-1, nil, true) end),
	awful.key({ mods.SUPER, mods.SHIFT }, 'i', function() awful.tag.incnmaster(1, nil, true) end),
	awful.key({ mods.SUPER, mods.SHIFT }, 'd', function() awful.tag.incnmaster(-1, nil, true) end),
})

awful.keyboard.append_global_keybindings({
	awful.key({
		modifiers = { mods.SUPER },
		keygroup = 'numrow',
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end,
	}),
	awful.key({
		modifiers = { mods.SUPER, mods.SHIFT },
		keygroup = 'numrow',
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end,
	}),
})

client.connect_signal('request::default_mousebindings', function()
	awful.mouse.append_client_mousebindings({
		awful.button({}, 1, function(c) c:activate({ context = 'mouse_click' }) end),
		awful.button({ mods.SUPER }, 2, function(c) awful.client.floating.toggle(c) end),
		awful.button({ mods.SUPER }, 1, function(c) c:activate({ context = 'mouse_click', action = 'mouse_move' }) end),
		awful.button(
			{ mods.SUPER },
			3,
			function(c) c:activate({ context = 'mouse_click', action = 'mouse_resize' }) end
		),
	})
end)

client.connect_signal('request::default_keybindings', function()
	awful.keyboard.append_client_keybindings({
		awful.key({ mods.SUPER, mods.SHIFT }, 'f', function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end),
		awful.key({ mods.SUPER, mods.SHIFT }, 'q', function(c) c:kill() end),
		awful.key({ mods.SUPER, mods.SHIFT }, 'space', awful.client.floating.toggle),
		awful.key({ mods.SUPER, mods.SHIFT }, 'o', function(c) c:move_to_screen() end),
		awful.key({ mods.SUPER }, 'n', function(c) c.minimized = true end),
	})
end)

-- Layouts
awful.keyboard.append_global_keybindings({
	awful.key({ mods.SUPER }, 't', function() awful.layout.set(awful.layout.suit.tile) end),
	awful.key({ mods.SUPER }, 'm', function() awful.layout.set(awful.layout.suit.max) end),
	-- awful.key({ mods.SUPER }, 'f', function() awful.layout.set(awful.layout.suit.floating) end),
})

-- }}}

-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal('request::rules', function()
	-- All clients will match this rule.
	ruled.client.append_rule({
		id = 'global',
		rule = {},
		properties = {
			focus = awful.client.focus.filter,
			raise = true,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
		callback = awful.client.setslave,
	})

	-- Floating clients.
	ruled.client.append_rule({
		id = 'floating',
		rule_any = {
			instance = { 'copyq', 'pinentry' },
			class = {
				'Arandr',
				'Blueman-manager',
				'Gpick',
				'Kruler',
				'Sxiv',
				'Tor Browser',
				'Wpa_gui',
				'veromix',
				'xtightvncviewer',
			},
			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				'Event Tester', -- xev.
			},
			role = {
				'AlarmWindow', -- Thunderbird's calendar.
				'ConfigManager', -- Thunderbird's about:config.
				'pop-up', -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	})

	-- Add titlebars to normal clients and dialogs
	ruled.client.append_rule({
		id = 'titlebars',
		rule_any = { type = { 'normal', 'dialog' } },
		properties = { titlebars_enabled = true },
	})

	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- ruled.client.append_rule {
	--     rule       = { class = "Firefox"     },
	--     properties = { screen = 1, tag = "2" }
	-- }
end)
-- }}}

client.connect_signal('property::floating', function(c)
	c.ontop = c.floating and not c.fullscreen

	if c.floating then
		awful.placement.centered(c)
		awful.placement.no_offscreen(c)
	end
end)

-- {{{ Notifications

ruled.notification.connect_signal('request::rules', function()
	-- All notifications will match this rule.
	ruled.notification.append_rule({
		rule = {},
		properties = {
			screen = awful.screen.preferred,
			implicit_timeout = 5,
		},
	})
end)

naughty.connect_signal('request::display', function(n) naughty.layout.box({ notification = n }) end)

-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal('mouse::enter', function(c) c:activate({ context = 'mouse_enter', raise = false }) end)
