local awful = require('awful')
local wibox = require('wibox')
local theme = require('beautiful')
local utils = require('widgets.utils')

local widget = function(screen)
  local function icons_callback(self, c, index, objects)
    local apps = theme.app_icons
    local app = apps[c.name] and apps[c.name] or apps[c.class] and apps[c.class] or apps.default
    local icon, color = app.icon, app.color

    color = not c.active and theme.app_inactive or color
    color = c.minimized and theme.app_minimized or color
    local bg = not c.active and theme.widget_background or theme.app_background

    self:get_children_by_id('app_role')[1].text = icon
    self:get_children_by_id('color_role')[1].fg = color
    self:get_children_by_id('color_role')[1].bg = bg
  end

  local result = awful.widget.tasklist({
    screen = screen,
    filter = awful.widget.tasklist.filter.currenttags,
    layout = { layout = wibox.layout.fixed.vertical, spacing = 2 },
    buttons = {
      awful.button({}, 1, function(c) c:activate({ context = 'tasklist' }) end),
      awful.button({}, 3, function(c) c.minimized = not c.minimized end),
      awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
      awful.button({}, 5, function() awful.client.focus.byidx(1) end),
    },
    widget_template = {
      {
        {
          id = 'app_role',
          widget = wibox.widget.textbox,
          font = theme.icon_font,
        },
        halign = 'center',
        valign = 'center',
        widget = wibox.container.place,
      },
      id = 'color_role',
      forced_height = theme.sidebar_width - theme.widget_margin * 2,
      forced_width = theme.sidebar_width,
      shape = theme.widget_shape,
      widget = wibox.container.background,
      create_callback = icons_callback,
      update_callback = icons_callback,
    },
  })

  return utils.add_widget_background(result)
end

return widget
