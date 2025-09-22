local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')

local menu = awful.popup({
	widget = {
		{
			text = '',
			widget = wibox.widget.textbox,
			font = beautiful.icon_font,
			halign = 'center',
		},
		{
			widget = wibox.widget.systray,
		},
		border_width = 5,
		placement = awful.placement.bottom_left,
		-- shape = gears.shape.rounded_rect,
		visible = true,
	},
})

local widget = {
	{
		{
			{
				text = '',
				widget = wibox.widget.textbox,
				font = beautiful.icon_font,
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
	buttons = {
		awful.button({}, 1, function() menu.visible = not menu.visible end),
	},
}

return { setup = function() return widget end }
