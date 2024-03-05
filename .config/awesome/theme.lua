---------------------------
-- Default awesome theme --
---------------------------

local xresources = require('beautiful.xresources')
local rnotification = require('ruled.notification')
local dpi = xresources.apply_dpi

local gears = require('gears')

local theme = {}

theme.app_icons = {}
-- stylua: ignore start
theme.app_icons.default   = { icon = '󰧭', color = '#a6adc8' }
theme.app_icons.kitty     = { icon = '', color = '#b4befe' }
theme.app_icons.firefox   = { icon = '', color = '#fab387' }
-- stylua: ignore end

theme.layout_icons = { tile = '󰙀', max = '' }

theme.app_inactive = '#45475a'
theme.app_minimized = '#1e1e2e'
theme.app_background = '#181825'

theme.font = 'BerkeleyMono Nerd Font Mono Bold 10'
theme.icon_font = 'BerkeleyMono Nerd Font Mono 12'
theme.clock_font = 'BerkeleyMono Nerd Font Mono Bold 8'

theme.widget_background = '#0a0a10'
theme.widget_shape = function(cr, w, h) return gears.shape.rounded_rect(cr, w, h, 5) end
theme.widget_margin = 2

theme.sidebar_width = dpi(25)
theme.sidebar_position = 'left'

theme.bg_normal = '#11111b'
theme.bg_focus = '#11111b'
theme.bg_urgent = '#ff0000'
theme.bg_minimize = '#444444'
theme.bg_systray = theme.bg_normal

theme.fg_normal = '#585b70'
theme.fg_focus = '#585b70'
theme.fg_urgent = '#585b70'
theme.fg_minimize = '#585b70'

theme.useless_gap = dpi(2)
theme.border_width = dpi(1)
theme.border_color_normal = '#1e1e2e'
theme.border_color_active = '#333444'
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
