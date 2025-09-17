local wibox = require('wibox')
local gears = require('gears')

local widget = {
	{
		{
			{
				text = '⏻',
				widget = wibox.widget.textbox,
				-- font = theme.icon_font,
				halign = 'center',
			},
			top = 1,
			bottom = 2,
			widget = wibox.container.margin,
		},
		shape = function(cr, w, h) return gears.shape.rounded_rect(cr, w, h, 5) end,
		widget = wibox.container.background,
	},
	margins = 5,
	widget = wibox.container.margin,
}

return { setup = function() return widget end }
