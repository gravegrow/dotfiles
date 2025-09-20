local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local theme = require('beautiful')
local naughty = require('naughty')

local function update_volume()
	awful.spawn.easy_async('wpctl get-volume @DEFAULT_AUDIO_SINK@ ', function(stdout)
		local muted = string.find(stdout, '[MUTED]')
		if muted then
			naughty.notify({ text = stdout })
			return
		end
		local volume_match = string.match(stdout, 'Volume: (%d?%.?%d+)')
		naughty.notify({ text = volume_match })
	end)
end

local widget = {
	{
		text = '󰕾',
		widget = wibox.widget.textbox,
		halign = 'center',
		font = theme.icon_font,
	},
	widget = wibox.container.margin,
	buttons = gears.table.join(
		awful.button({}, 1, function()
			-- update_volume()
			awful.spawn('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+')
		end),
		awful.button({}, 3, function()
			awful.spawn('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-')
			-- update_volume()
		end),
		awful.button({}, 4, function()
			awful.spawn('wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+')
			-- update_volume()
		end),
		awful.button({}, 5, function()
			awful.spawn('wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-')
			-- update_volume()
		end),
		awful.button({}, 2, function()
			awful.spawn('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle')
			-- update_volume()
		end)
	),
}
return { setup = function() return widget end }
