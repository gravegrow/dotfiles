local wibox = require('wibox')
local theme = require('beautiful')
local utils = require('widgets.utils')

return function()
  return utils.add_widget_background({
    {
      {
        widget = wibox.widget.textclock('%H'),
        halign = 'center',
        font = theme.clock_font,
      },
      {
        {
          widget = wibox.widget.textbox('──'),
          halign = 'center',
          font = theme.clock_font,
        },
        widget = wibox.container.margin,
        top = -5,
        bottom = -5,
      },
      {
        widget = wibox.widget.textclock('%M'),
        halign = 'center',
        font = theme.clock_font,
      },
      layout = wibox.layout.fixed.vertical,
    },
    widget = wibox.container.margin,
    top = 5,
    bottom = 5,
  })
end
