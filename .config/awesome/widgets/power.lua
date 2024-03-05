local wibox = require('wibox')

return function()
  return {
    {
      text = '',
      widget = wibox.widget.textbox,
      halign = 'center',
    },
    widget = wibox.container.margin,
    bottom = 5,
  }
end
