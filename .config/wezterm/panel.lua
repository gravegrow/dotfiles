local wezterm = require('wezterm')
local M = {}

---@param config _.wezterm.ConfigBuilder
function M.setup(config)
    config.use_fancy_tab_bar = false
    config.hide_tab_bar_if_only_one_tab = true
    config.tab_max_width = 35
    config.colors = {
        tab_bar = M.colors,
    }
    return M
end

M.colors = {
    background = '#11111a',

    new_tab = {
        bg_color = '#11111a',
        fg_color = '#11111a',
    },

    new_tab_hover = {
        bg_color = '#1e1e2e',
        fg_color = '#909090',
    },
}

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local title = tab.tab_title or ''
    local index = ' ' .. tab.tab_index + 1 .. ' '
    local icon = ''
    local session = ''

    if tab.tab_index == 0 then
        icon = '  '
        session = ' ' .. 'Session' .. ' '

        for i, v in ipairs(config.unix_domains) do
            if v.name ~= nil and v.name ~= '' then
                session = v.name
                break
            end
        end
    end

    local background = '#181825'
    local foreground = '#45475a'
    local intensity = 'Normal'

    if tab.is_active then
        background = '#89b4fa'
        foreground = '#11111a'
        intensity = 'Bold'
    end

    return {
        { Attribute = { Intensity = 'Bold' } },
        { Background = { Color = '#f38ba8' } },
        { Foreground = { Color = '#11111a' } },
        { Text = icon },

        { Background = { Color = '#11111a' } },
        { Foreground = { Color = '#bac2de' } },
        { Text = session },

        { Attribute = { Intensity = intensity } },
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = index },
        { Text = title },
    }
end)

return M
