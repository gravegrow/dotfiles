local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')

local setup = function(scr)
	return awful.widget.taglist({
		screen = scr,
		filter = function(t) return #t:clients() > 0 and t.index < 6 or t.selected end,
		layout = wibox.layout.fixed.vertical,
		style = {
			shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 5) end,
		},
		widget_template = {
			{
				{
					{
						{
							id = 'text_role',
							valign = 'center',
							widget = wibox.widget.textbox,
						},
						valign = 'center',
						widget = wibox.container.place,
					},
					top = 3,
					bottom = 3,
					widget = wibox.container.margin,
				},
				id = 'background_role',
				widget = wibox.container.background,
			},
			margins = 5,
			widget = wibox.container.margin,
		},

		buttons = {
			awful.button({}, 1, function(t) t:view_only() end),
			awful.button({ 'Mod4' }, 1, function(t)
				if client.focus then
					client.focus:move_to_tag(t)
				end
			end),
		},
	})
end

return { setup = setup }
