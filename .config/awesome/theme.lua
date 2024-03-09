---------------------------
-- Default awesome theme --
---------------------------

local xresources = require('beautiful.xresources')
local rnotification = require('ruled.notification')
local dpi = xresources.apply_dpi

local gears = require('gears')

local theme = {}

theme.app_icons = {}
theme.app_icons['org.wezfurlong.wezterm'] = { icon = '', color = '#b4befe' }
theme.app_icons.default = { icon = '󰧭', color = '#a6adc8' }
theme.app_icons.firefox = { icon = '', color = '#fab387' }

theme.layout_icons = { tile = '󰙀', max = '' }
theme.selected = '#25211E'

theme.app_inactive = '#45475a'
theme.app_minimized = '#1e1e2e'
theme.app_selected = theme.selected

theme.font = 'BerkeleyMono Nerd Font Mono Bold 12'
theme.icon_font = 'BerkeleyMono Nerd Font Mono 14'
theme.clock_font = 'BerkeleyMono Nerd Font Mono Bold 10'

theme.sidebar_width = 35
theme.sidebar_position = 'left'
theme.sidebar_margin = 0

theme.widget_background = '#0a0a0a'
theme.widget_shape = function(cr, w, h) return gears.shape.rounded_rect(cr, w, h, 5) end
theme.widget_margin = 5

theme.green = '#A1ABA0'
theme.bg_normal = '#141110'
theme.bg_focus = '#141110'
theme.bg_urgent = '#ff0000'
theme.bg_minimize = '#444444'
theme.bg_systray = theme.bg_normal

theme.fg_normal = '#6E6763'
theme.fg_focus = '#6E6763'
theme.fg_urgent = '#6E6763'
theme.fg_minimize = '#6E6763'

theme.useless_gap = dpi(0)
theme.border_width = dpi(2)
theme.border_color_normal = theme.bg_normal
theme.border_color_active = theme.selected
theme.border_color_marked = '#91231c'

theme.taglist_fg_focus = '#89b4fa'
theme.taglist_fg_occupied = '#45475a'
theme.taglist_fg_empty = '#45475a'

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

theme.wallpaper = nil

-- Set different colors for urgent notifications.
rnotification.connect_signal(
	'request::rules',
	function()
		rnotification.append_rule({
			rule = { urgency = 'critical' },
			properties = { bg = '#ff0000', fg = '#ffffff' },
		})
	end
)

return theme
