local wibox = require('wibox')
local theme = require('beautiful')
local M = {}

function M.add_widget_background(widget)
  return {
    {
      widget,
      widget = wibox.container.background,
      bg = theme.widget_background,
      shape = theme.widget_shape,
    },
    widget = wibox.container.margin,
    margins = theme.widget_margin,
  }
end

return M
