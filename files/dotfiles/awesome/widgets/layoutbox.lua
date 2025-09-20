local beautiful = require('beautiful')
local wibox = require('wibox')

local setup = function(scr)
	local layouts = wibox.widget.textbox(beautiful.layout_icons.tile)
	local function callback(tag)
		layouts.text = beautiful.layout_icons[tag.layout.name] or beautiful.layout_icons.fallback
	end
	for _, tag in pairs(scr.tags) do
		tag:connect_signal('property::layout', callback)
		tag:connect_signal('property::selected', callback)
	end

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
