-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, 'luarocks.loader')

-- Standard awesome library
local gears = require('gears')
local awful = require('awful')
require('awful.autofocus')
-- Widget and layout library
local wibox = require('wibox')
-- Theme handling library
local theme = require('beautiful')
-- Notification library
local naughty = require('naughty')
-- Declarative object management
local ruled = require('ruled')

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
theme.init(gears.filesystem.get_configuration_dir() .. 'theme.lua')

local terminal = 'kitty'
local mods = {
  SUPER = 'Mod4',
  SHIFT = 'Shift',
  CONTROL = 'Control',
}
-- }}}

-- {{{ Tag layout
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal(
  'request::default_layouts',
  function()
    awful.layout.append_default_layouts({
      awful.layout.suit.tile,
      awful.layout.suit.max,
    })
  end
)
-- }}}

-- {{{ Wallpaper
screen.connect_signal(
  'request::wallpaper',
  function(s)
    awful.wallpaper({
      screen = s,
      widget = {
        { image = theme.wallpaper, upscale = true, downscale = true, widget = wibox.widget.imagebox },
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

-- Create a textclock widget
local textclock = wibox.widget.textclock()

screen.connect_signal('request::desktop_decoration', function(self)
  -- Each screen has its own tag table.
  awful.tag({ '1', '2', '3', '4', '5', '6', '7', '8', '9' }, self, awful.layout.layouts[1])

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  self.layoutbox = awful.widget.layoutbox({ screen = self })

  local taglist_callback = function(self, c3, index, objects)
    local focused = false
    for _, x in pairs(awful.screen.focused().selected_tags) do
      if x.index == index then
        focused = true
        break
      end
    end
    local bg = focused and theme.taglist_fg_focus or theme.taglist_underline_occupied
    self:get_children_by_id('underline')[1].bg = bg
  end

  -- Create a taglist widget
  self.taglist = awful.widget.taglist({
    screen = self,
    filter = awful.widget.taglist.filter.noempty,

    widget_template = {
      {
        id = 'text_role',
        widget = wibox.widget.textbox,
      },
      margins = 5,
      widget = wibox.container.margin,
    },

    buttons = {
      awful.button({}, 1, function(t) t:view_only() end),
      awful.button({ mods.SUPER }, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
      end),
    },
  })

  -- Create a tasklist widget
  self.tasklist = awful.widget.tasklist({
    screen = self,
    filter = awful.widget.tasklist.filter.focused,
    widget_template = {
      {
        layout = wibox.layout.align.horizontal,
        expand = 'outside',

        { widget = wibox.container.margin },
        { id = 'text_role', widget = wibox.widget.textbox },
        { widget = wibox.container.margin },
      },
      widget = wibox.container.margin,
    },
  })

  -- Create the wibox
  self.mywibox = awful.wibar({
    position = 'top',
    screen = self,
    widget = {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        self.taglist,
      },
      self.tasklist, -- Middle widget
      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        wibox.widget.systray(),
        textclock,
        self.layoutbox,
      },
    },
  })
end)

-- }}}

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings({
  awful.button({}, 4, awful.tag.viewprev),
  awful.button({}, 5, awful.tag.viewnext),
})
-- }}}

-- {{{ Key bindings

-- General Awesome keys
awful.keyboard.append_global_keybindings({
  awful.key({ mods.SUPER }, 'b', function() mouse.screen.mywibox.visible = not mouse.screen.mywibox.visible end),

  awful.key({ mods.SUPER, mods.CONTROL }, 'r', awesome.restart, {
    description = 'reload awesome',
    group = 'awesome',
  }),

  awful.key({ mods.SUPER }, 'Return', function() awful.spawn(terminal) end, {
    description = 'open a terminal',
    group = 'launcher',
  }),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
  awful.key({ mods.SUPER }, 'Escape', awful.tag.history.restore, {
    description = 'go back',
    group = 'tag',
  }),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
  awful.key({ mods.SUPER }, 'j', function() awful.client.focus.byidx(1) end, {
    description = 'focus next by index',
    group = 'client',
  }),
  awful.key({ mods.SUPER }, 'k', function() awful.client.focus.byidx(-1) end, {
    description = 'focus previous by index',
    group = 'client',
  }),
  awful.key({ mods.SUPER, mods.CONTROL }, 'j', function() awful.screen.focus_relative(1) end, {
    description = 'focus the next screen',
    group = 'screen',
  }),
  awful.key({ mods.SUPER, mods.CONTROL }, 'k', function() awful.screen.focus_relative(-1) end, {
    description = 'focus the previous screen',
    group = 'screen',
  }),
  awful.key({ mods.SUPER, mods.SHIFT }, 'n', function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then c:activate({
      raise = true,
      context = 'key.unminimize',
    }) end
  end, {
    description = 'restore minimized',
    group = 'client',
  }),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
  awful.key({ mods.SUPER, mods.SHIFT }, 'j', function() awful.client.swap.byidx(1) end, {
    description = 'swap with next client by index',
    group = 'client',
  }),
  awful.key({ mods.SUPER, mods.SHIFT }, 'k', function() awful.client.swap.byidx(-1) end, {
    description = 'swap with previous client by index',
    group = 'client',
  }),
  awful.key({ mods.SUPER }, 'l', function() awful.tag.incmwfact(0.05) end, {
    description = 'increase master width factor',
    group = 'layout',
  }),
  awful.key({ mods.SUPER }, 'h', function() awful.tag.incmwfact(-0.05) end, {
    description = 'decrease master width factor',
    group = 'layout',
  }),
  awful.key({ mods.SUPER }, 'i', function() awful.tag.incncol(1, nil, true) end, {
    description = 'increase the number of columns',
    group = 'layout',
  }),
  awful.key({ mods.SUPER }, 'd', function() awful.tag.incncol(-1, nil, true) end, {
    description = 'decrease the number of columns',
    group = 'layout',
  }),
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
      if tag then tag:view_only() end
    end,
  }),
  awful.key({
    modifiers = {
      mods.SUPER,
      mods.CONTROL,
    },
    keygroup = 'numrow',
    description = 'toggle tag',
    group = 'tag',
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then awful.tag.viewtoggle(tag) end
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
        if tag then client.focus:move_to_tag(tag) end
      end
    end,
  }),
  awful.key({
    modifiers = {
      mods.SUPER,
      mods.CONTROL,
      mods.SHIFT,
    },
    keygroup = 'numrow',
    description = 'toggle focused client on tag',
    group = 'tag',
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then client.focus:toggle_tag(tag) end
      end
    end,
  }),
  awful.key({
    modifiers = { mods.SUPER },
    keygroup = 'numpad',
    description = 'select layout directly',
    group = 'layout',
    on_press = function(index)
      local t = awful.screen.focused().selected_tag
      if t then t.layout = t.layouts[index] or t.layout end
    end,
  }),
})

client.connect_signal('request::default_mousebindings', function()
  awful.mouse.append_client_mousebindings({
    awful.button({}, 1, function(c)
      c:activate({
        context = 'mouse_click',
      })
    end),
    awful.button(
      { mods.SUPER },
      1,
      function(c)
        c:activate({
          context = 'mouse_click',
          action = 'mouse_move',
        })
      end
    ),
    awful.button(
      { mods.SUPER },
      3,
      function(c)
        c:activate({
          context = 'mouse_click',
          action = 'mouse_resize',
        })
      end
    ),
  })
end)

client.connect_signal('request::default_keybindings', function()
  awful.keyboard.append_client_keybindings({
    awful.key({ mods.SUPER, mods.SHIFT }, 'f', function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end, {
      description = 'toggle fullscreen',
      group = 'client',
    }),
    awful.key({ mods.SUPER, mods.SHIFT }, 'q', function(c) c:kill() end, {
      description = 'close',
      group = 'client',
    }),
    awful.key({ mods.SUPER, mods.CONTROL }, 'space', awful.client.floating.toggle, {
      description = 'toggle floating',
      group = 'client',
    }),
    awful.key({ mods.SUPER, mods.CONTROL }, 'Return', function(c) c:swap(awful.client.getmaster()) end, {
      description = 'move to master',
      group = 'client',
    }),
    awful.key({ mods.SUPER }, 'o', function(c) c:move_to_screen() end, {
      description = 'move to screen',
      group = 'client',
    }),
    awful.key({ mods.SUPER }, 't', function(c) c.ontop = not c.ontop end, {
      description = 'toggle keep on top',
      group = 'client',
    }),
    awful.key({ mods.SUPER }, 'n', function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end, {
      description = 'minimize',
      group = 'client',
    }),
    awful.key({ mods.SUPER }, 'm', function(c)
      c.maximized = not c.maximized
      c:raise()
    end, {
      description = '(un)maximize',
      group = 'client',
    }),
    awful.key({ mods.SUPER, mods.CONTROL }, 'm', function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end, {
      description = '(un)maximize vertically',
      group = 'client',
    }),
    awful.key({ mods.SUPER, mods.SHIFT }, 'm', function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end, {
      description = '(un)maximize horizontally',
      group = 'client',
    }),
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
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      maximized_vertical = false,
      maximized_horizontal = false,
    },

    callback = awful.client.setslave,
  })

  -- Floating clients.
  ruled.client.append_rule({
    id = 'floating',
    rule_any = {
      instance = {
        'copyq',
        'pinentry',
      },
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
    properties = {
      floating = true,
    },
  })

  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- ruled.client.append_rule {
  --     rule       = { class = "Firefox"     },
  --     properties = { screen = 1, tag = "2" }
  -- }
end)
-- }}}

-- {{{ Titlebars
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal('request::titlebars', function(c)
  -- buttons for the titlebar
  local buttons = {
    awful.button(
      {},
      1,
      function()
        c:activate({
          context = 'titlebar',
          action = 'mouse_move',
        })
      end
    ),
    awful.button(
      {},
      3,
      function()
        c:activate({
          context = 'titlebar',
          action = 'mouse_resize',
        })
      end
    ),
  }

  awful.titlebar(c).widget = {
    { -- Left
      awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout = wibox.layout.fixed.horizontal,
    },
    { -- Middle
      { -- Title
        halign = 'center',
        widget = awful.titlebar.widget.titlewidget(c),
      },
      buttons = buttons,
      layout = wibox.layout.flex.horizontal,
    },
    { -- Right
      awful.titlebar.widget.floatingbutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.stickybutton(c),
      awful.titlebar.widget.ontopbutton(c),
      awful.titlebar.widget.closebutton(c),
      layout = wibox.layout.fixed.horizontal(),
    },
    layout = wibox.layout.align.horizontal,
  }
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
client.connect_signal(
  'mouse::enter',
  function(c)
    c:activate({
      context = 'mouse_enter',
      raise = false,
    })
  end
)
