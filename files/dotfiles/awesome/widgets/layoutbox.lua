local beautiful = require('beautiful')
local wibox = require('wibox')

local setup = function(scr)
	local layouts = wibox.widget.textbox(beautiful.layout_icons.tile)
	scr.selected_tag:connect_signal(
		'property::layout',
		function(t) layouts.text = beautiful.layout_icons[t.layout.name] or beautiful.layout_icons.fallback end
	)

	local widget = {
		{
			{
				layouts,
				-- fg = theme.fg_normal,
				widget = wibox.container.background,
			},
			top = 5,
			widget = wibox.container.margin,
		},
		widget = wibox.container.place,
	}

	return widget
end

return { setup = setup }
