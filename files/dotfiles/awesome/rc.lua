-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, 'luarocks.loader')

require('awful.autofocus')
local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local theme = require('beautiful')
local naughty = require('naughty')
local ruled = require('ruled')
local widgets = require('widgets')

awful.spawn.with_shell('dwm-autostart')
theme.init(gears.filesystem.get_configuration_dir() .. 'theme.lua')

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

screen.connect_signal('request::desktop_decoration', function(self)
	awful.tag({ '1', '2', '3', '4', '5', '6', '7', '8', '9' }, self, awful.layout.suit.tile)
	self.systray = {
		{
			widget = wibox.widget.systray,
			horizontal = false,
		},
		margins = 8,
		widget = wibox.container.margin,
	}

	self.sidebar = awful.wibar({
		position = theme.sidebar_position,
		-- position = self == screen[1] and 'right' or 'left',
		width = theme.sidebar_width,
		screen = self,
		widget = {
			layout = wibox.layout.align.vertical,
			{
				layout = wibox.layout.fixed.vertical,
				spacing = 20,
				{
					widgets.layoutbox(),
					widgets.taglist(self),
					layout = wibox.layout.fixed.vertical,
					spacing = 2,
				},
				widgets.tasklist(self),
			},
			{
				valign = 'center',
				widget = wibox.container.place,
			},
			{
				layout = wibox.layout.fixed.vertical,
				self.systray,
				widgets.volume(),
				widgets.clock(),
				widgets.power(),
			},
		},
	})
end)

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

-- Volume
awful.keyboard.append_global_keybindings({
	awful.key({}, '#123', function()
		awful.spawn('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+')
		awesome.emit_signal('volume_change')
	end),
	awful.key({}, '#122', function()
		awful.spawn('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-')
		awesome.emit_signal('volume_change')
	end),
	awful.key({}, '#121', function()
		awful.spawn('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle')
		awesome.emit_signal('volume_change')
	end),
})

-- Layouts
awful.keyboard.append_global_keybindings({
	awful.key({ mods.SUPER }, 't', function() awful.layout.set(awful.layout.suit.tile) end),
	awful.key({ mods.SUPER }, 'm', function() awful.layout.set(awful.layout.suit.max) end),
	awful.key({ mods.SUPER }, 'f', function() awful.layout.set(awful.layout.suit.floating) end),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
	awful.key({ mods.SUPER }, 'k', function() awful.client.focus.byidx(1) end),
	awful.key({ mods.SUPER }, 'j', function() awful.client.focus.byidx(-1) end),
	awful.key({ mods.SUPER, mods.CONTROL }, 'j', function() awful.screen.focus_relative(1) end),
	awful.key({ mods.SUPER, mods.CONTROL }, 'k', function() awful.screen.focus_relative(-1) end),
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
	awful.key({ mods.SUPER }, 'l', function() awful.tag.incmwfact(0.05) end),
	awful.key({ mods.SUPER }, 'h', function() awful.tag.incmwfact(-0.05) end),
	awful.key({ mods.SUPER }, 'i', function() awful.tag.incncol(1, nil, true) end),
	awful.key({ mods.SUPER }, 'd', function() awful.tag.incncol(-1, nil, true) end),
})

awful.keyboard.append_global_keybindings({
	awful.key({
		modifiers = { mods.SUPER },
		keygroup = 'numrow',
		description = 'only view tag',
		group = 'tag',
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
		description = 'move focused client to tag',
		group = 'tag',
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
		end, { description = 'toggle fullscreen' }),
		awful.key(
			{ mods.SUPER, mods.CONTROL },
			'Return',
			function(c) c:swap(awful.client.getmaster()) end,
			{ description = 'move to master' }
		),
		awful.key({ mods.SUPER, mods.SHIFT }, 'q', function(c) c:kill() end, { description = 'close' }),
		awful.key({ mods.SUPER, mods.SHIFT }, 'space', function(c) awful.client.floating.toggle() end),
		awful.key({ mods.SUPER }, 'o', function(c) c:move_to_screen() end, { description = 'move to screen' }),
		awful.key({ mods.SUPER }, 'n', function(c) c.minimized = true end, { description = 'minimize' }),
	})
end)

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
			placement = awful.placement.centered + awful.placement.no_offscreen,
		},
		callback = awful.client.setslave,
	})

	ruled.client.append_rule({
		id = 'floating',
		rule_any = {
			instance = {},
			class = {
				'Arandr',
				'Blueman-manager',
				'Gpick',
				'Lutris',
				'gnome-calculator',
				'gnome-calendar',
			},
			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				'Event Tester', -- xev.
			},
			role = {},
		},
		properties = {
			floating = true,
			-- shape = theme.floating_shape,
		},
	})

	ruled.client.append_rule({
		rule = { class = 'discord' },
		properties = { screen = 2, tag = '2' },
	})

	ruled.client.append_rule({
		rule = { class = 'Spotify' },
		properties = { screen = 2, tag = '3' },
	})

	ruled.client.append_rule({
		rule = { class = 'qBittorrent' },
		properties = { screen = 2, tag = '5' },
	})
end)
-- }}}

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

naughty.connect_signal('request::display', function(n)
	naughty.layout.box({
		notification = n,
	})
end)

-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal('mouse::enter', function(c)
	c:activate({
		context = 'mouse_enter',
		raise = false,
	})
end)

client.connect_signal('property::maximized', function(c)
	if not c.maximized then
		return
	end
	c.maximized = false
end)

client.connect_signal('property::floating', function(c)
	c.ontop = c.floating and not c.fullscreen

	if c.floating then
		awful.placement.centered(c)
		awful.placement.no_offscreen(c)
	end
end)

local multibox = {}
multibox.name = 'multibox'
multibox.arrange = function(p)
	local workarea = p.workarea
	local clients = p.clients
	local terminal_width = 200

	local geometry = {
		height = workarea.height,
		x = workarea.x,
		y = workarea.y,
	}

	geometry.width = workarea.width / 2
	clients[1]:geometry(geometry)

	geometry.width = workarea.width / 2
	geometry.x = clients[2]:geometry(geometry)

	geometry.width = terminal_width
	geometry.height = terminal_width
	clients[3]:geometry(geometry)

	for i = 4, #clients do
		local g = {}
		g.width = 1280
		g.height = 720

		clients[i]:geometry(g)
		clients[i].floating = true
		clients[i].ontop = true
		awful.placement.centered(clients[i])
	end
end

awful.layout.set(multibox, screen[1].tags[6])
awful.layout.set(multibox, screen[1].tags[7])
