local awful = require('awful')
local wibox = require('wibox')

return function(screen)
  return awful.widget.taglist({
    screen = screen,
    filter = function(t) return #t:clients() > 0 and t.index < 6 or t.selected end,
    layout = wibox.layout.fixed.vertical,
    widget_template = {
      {
        id = 'text_role',
        valign = 'center',
        widget = wibox.widget.textbox,
      },
      valign = 'center',
      widget = wibox.container.place,
    },

    buttons = {
      awful.button({}, 1, function(t) t:view_only() end),
      awful.button({ 'Mod4' }, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
      end),
    },
  })
end
