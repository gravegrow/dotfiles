pcall(require, 'luarocks.loader')
local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local naughty = require('naughty')
local ruled = require('ruled')
local menubar = require('menubar')
-- local hotkeys_popup = require('awful.hotkeys_popup')
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
-- require('awful.hotkeys_popup.keys')
require('awful.autofocus')

-- {{{ Error handling
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
beautiful.init(gears.filesystem.get_configuration_dir() .. 'theme.lua')

local mods = {
	SUPER = 'Mod4',
	SHIFT = 'Shift',
	CONTROL = 'Control',
}

local apps = {
	terminal = 'wezterm',
	launcher = 'dwm-applauncher',
	browser = 'dwm-browser',
	browser_private = 'dwm-browser-private',
	files_tui = 'dwm-files-tui',
	files_gui = 'dwm-files-gui',
	colorpicker = 'dwm-gpick',
	screengrab = 'dwm-screengrab',
	screenshot = 'dwm-screenshot',
}

local spacer = wibox.container.background({ forced_height = 5 })

screen.connect_signal('request::desktop_decoration', function(scr)
	awful.tag({ '1', '2', '3', '4', '5', '6', '7', '8', '9' }, scr, awful.layout.suit.tile)

	scr.systray = {
		{
			widget = wibox.widget.systray,
			horizontal = false,
		},
		margins = 8,
		widget = wibox.container.margin,
	}

	scr.panel = awful.wibar({
		position = 'left',
		width = beautiful.panel_width,
		screen = scr,
		widget = {
			layout = wibox.layout.align.vertical,
			{
				layout = wibox.layout.fixed.vertical,
				require('widgets.layoutbox').setup(scr),
				require('widgets.taglist').setup(scr),
			},
			{
				valign = 'center',
				widget = wibox.container.place,
			},
			{
				layout = wibox.layout.fixed.vertical,

				require('widgets.volume').setup(),
				spacer,
				require('widgets.clock').setup(),
				spacer,
				require('widgets.settings').setup(),
				spacer,
				-- require('widgets.power_button').setup(),
			},
		},
	})
end)

-- {{{ Key bindings

-- General Awesome keys
awful.keyboard.append_global_keybindings({
	awful.key({ mods.SUPER }, 'w', function() mouse.screen.panel.visible = not mouse.screen.panel.visible end),
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
	awful.key({ mods.SUPER }, 'i', function()
		awful.tag.incncol(1, nil, true)
		local selected_tag = awful.screen.focused().selected_tag
		local column_count = selected_tag.column_count
		selected_tag.master_width_factor = beautiful.master_width_factor / column_count
	end),
	awful.key({ mods.SUPER }, 'd', function()
		awful.tag.incncol(-1, nil, true)
		local selected_tag = awful.screen.focused().selected_tag
		local column_count = selected_tag.column_count
		selected_tag.master_width_factor = beautiful.master_width_factor / column_count
	end),
	awful.key({ mods.SUPER, mods.SHIFT }, 'i', function() awful.tag.incnmaster(1, nil, true) end),
	awful.key({ mods.SUPER, mods.SHIFT }, 'd', function() awful.tag.incnmaster(-1, nil, true) end),
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

-- Tags
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
			size_hints_honor = false,
		},
		callback = awful.client.setslave,
	})

	-- Floating clients.
	ruled.client.append_rule({
		id = 'floating',
		rule_any = {
			instance = {},
			class = {
				'Arandr',
				'Blueman-manager',
				'Gpick',
				'gnome-calculator',
				'gnome-calendar',
				'pavucontrol',
				'zenity',
			},
			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				'Event Tester', -- xev.
			},
			role = {
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

	ruled.client.append_rule({
		rule_any = {
			class = { 'Lutris' },
		},
		properties = {
			tag = screen[2].tags[7],
			switch_to_tags = true,
			floating = true,
			callback = function(c)
				if not c.name == 'Lutris' then
					c.floating = false
				end
			end,
		},
	})

	ruled.client.append_rule({
		rule_any = {
			class = { 'Maya-2022' },
		},
		properties = {
			maximized = false,
			callback = function(c)
				local filter_names = { 'Maya', 'Autodesk' }
				local should_float = true

				for _, name in pairs(filter_names) do
					if c.name:find(name) then
						should_float = false
						break
					end
				end

				c.floating = should_float
			end,
		},
	})

	ruled.client.append_rule({
		rule_any = {
			class = { 'gamescope' },
		},
		properties = {
			screen = 1,
		},
	})

	ruled.client.append_rule({
		rule_any = {
			class = { 'KeePassXC' },
		},
		except = {
			name = 'Auto-Type - KeePassXC',
		},
		properties = {
			tag = screen[2].tags[6],
			switch_to_tags = true,
		},
	})

	ruled.client.append_rule({
		rule_any = {
			class = { 'qBittorrent' },
		},
		properties = {
			tag = screen[2].tags[5],
			switch_to_tags = true,
			callback = function(c)
				if not c.name:find('qBittorrent') then
					c.floating = true
				end
			end,
		},
	})
end)
-- }}}

client.connect_signal('property::floating', function(c)
	c.ontop = c.floating and not c.fullscreen

	if c.floating then
		awful.placement.centered(c)
		awful.placement.no_offscreen(c)
	end
end)

screen.connect_signal('arrange', function(s)
	local max = s.selected_tag.layout.name == 'max'
	local only_one = #s.tiled_clients == 1
	for _, c in pairs(s.clients) do
		if (max or only_one) and not c.floating or c.maximized then
			c.border_width = 0
		else
			c.border_width = beautiful.border_width
		end
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

-- Example: A simple custom layout that stacks all clients vertically

local function farming_arrange(tag)
	local area = tag.workarea

	for i, client in ipairs(tag.clients) do
		local geometry
		if i <= 2 then
			geometry = {
				x = area.x + (area.width / 2) * (i - 1) - beautiful.border_width,
				y = area.y,
				width = area.width / 2,
				height = area.height,
			}
		elseif i == 3 then
			geometry = {
				x = area.x,
				y = area.y,
				height = 320,
				width = 520,
			}
			client.ontop = true
		else
			geometry = {}
			client.floating = true
			client.ontop = true
			awful.placement.centered(client)
		end
		tag.geometries[client] = geometry
	end
end

local farming = {
	nama = 'farming',
	arrange = farming_arrange,
	skip_gap = function(nclients, t) return true end,
}

awful.keyboard.append_global_keybindings({
	awful.key({ mods.SUPER, mods.SHIFT }, 'm', function() awful.layout.set(farming) end),
})
