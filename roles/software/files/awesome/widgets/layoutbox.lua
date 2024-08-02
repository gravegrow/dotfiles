local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local theme = require('beautiful')
local naughty = require('naughty')
local ruled = require('ruled')

return function()
  local layouts = wibox.widget.textbox(theme.layout_icons[awful.layout.layouts[1].name])
  layouts.update = function(t) layouts.text = theme.layout_icons[t.layout.name] end
  tag.connect_signal('property::layout', layouts.update)

  local widget = {
    {
      {
        layouts,
        fg = theme.fg_normal,
        widget = wibox.container.background,
      },
      top = 5,
      widget = wibox.container.margin,
    },
    widget = wibox.container.place,
  }

  return widget
end
