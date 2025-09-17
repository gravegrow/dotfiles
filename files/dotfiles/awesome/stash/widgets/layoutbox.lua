local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')
local theme = require('beautiful')
local naughty = require('naughty')
local ruled = require('ruled')

return function()
	local layouts = wibox.widget.textbox(theme.layout_icons[awful.layout.suit.tile.name])
	tag.connect_signal(
		'property::layout',
		function(t) layouts.text = theme.layout_icons[t.layout.name] or theme.layout_icons.fallback end
	)

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
