local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local theme = require('beautiful')

return function()
  return {
    {
      text = '󰕾',
      widget = wibox.widget.textbox,
      halign = 'center',
      font = theme.icon_font,
    },
    bottom = 3,
    widget = wibox.container.margin,
    buttons = gears.table.join(
      awful.button({}, 1, function() awful.spawn('pactl set-sink-mute @DEFAULT_SINK@ toggle') end),
      awful.button({}, 3, function() awful.spawn('gnome-control-center sound') end),
      awful.button({}, 4, function()
        awful.spawn('pactl set-sink-volume @DEFAULT_SINK@ +5%')
        awesome.emit_signal('volume_change')
      end),
      awful.button({}, 5, function()
        awful.spawn('pactl set-sink-volume @DEFAULT_SINK@ -5%')
        awesome.emit_signal('volume_change')
      end)
    ),
  }
end
