local wibox = require('wibox')
local theme = require('beautiful')

return function()
	return {
		{
			text = '',
			widget = wibox.widget.textbox,
			-- font = theme.icon_font,
			halign = 'center',
		},
		widget = wibox.container.margin,
		bottom = 7,
		top = 7,
	}
end
