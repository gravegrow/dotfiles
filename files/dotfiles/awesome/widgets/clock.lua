local wibox = require('wibox')

local widget = {
	{
		{
			widget = wibox.widget.textclock('%H'),
			halign = 'center',
			-- font = beautiful.clock_font,
		},
		{
			{
				widget = wibox.widget.textbox('──'),
				halign = 'center',
				-- font = theme.clock_font,
			},
			widget = wibox.container.margin,
			top = -5,
			bottom = -5,
		},
		{
			widget = wibox.widget.textclock('%M'),
			halign = 'center',
			-- font = theme.clock_font,
		},
		layout = wibox.layout.fixed.vertical,
	},
	widget = wibox.container.margin,
	top = 5,
	bottom = 5,
}

return { setup = function() return widget end }
