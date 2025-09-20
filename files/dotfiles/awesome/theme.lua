---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require('beautiful.theme_assets')
local xresources = require('beautiful.xresources')
local rnotification = require('ruled.notification')
local dpi = xresources.apply_dpi

local gfs = require('gears.filesystem')
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.layout_icons = {
	fallback = '󰄶',
	tile = '󰙀',
	max = '',
}

theme.master_width_factor = 0.66
theme.font = 'BerkeleyMono Nerd Font Mono Bold 12'
theme.icon_font = 'BerkeleyMono Nerd Font Mono Bold 16'

theme.bg_normal = '#0a0a0a'
theme.bg_focus = '#535d6c'
theme.bg_urgent = '#ff0000'
theme.bg_minimize = '#444444'
theme.bg_systray = theme.bg_normal

theme.fg_normal = '#9A8F8A'
theme.fg_focus = '#ffffff'
theme.fg_urgent = '#ffffff'
theme.fg_minimize = '#ffffff'

theme.panel_width = dpi(35)
theme.useless_gap = dpi(5)
theme.gap_single_client = false
theme.border_width = dpi(1)
theme.border_color_normal = '#000000'
theme.border_color_active = '#535d6c'
theme.border_color_marked = '#91231c'

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
-- theme.taglist_bg_focus = '#1A1A1C'

theme.taglist_bg_focus = '#1F1F22'
theme.taglist_fg_focus = '#89b4fa'
theme.taglist_fg_occupied = '#7a726e'
theme.taglist_fg_empty = '#45475a'
-- theme.taglist_font = 'BerkeleyMono Nerd Font Mono Bold 12'

-- Generate taglist squares:
-- local taglist_square_size = dpi(4)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. 'default/submenu.png'
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

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

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
