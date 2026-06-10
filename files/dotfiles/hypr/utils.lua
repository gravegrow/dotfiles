local M = {}

M.switch_layout = function(layout)
    return function()
        hl.workspace_rule({
            workspace = tostring(hl.get_active_workspace().id),
            layout = layout,
        })
    end
end

M.swap_workspace = function(index)
    return function()
        local id = hl.get_active_monitor().id
        local i = id * 10 + index
        hl.dispatch(hl.dsp.focus({ workspace = i, on_current_monitor = true }))
    end
end

M.move_to_workspace = function(index)
    return function()
        local id = hl.get_active_monitor().id
        local i = id * 10 + index
        hl.dispatch(hl.dsp.window.move({
            workspace = i,
            on_current_monitor = true,
            follow = false,
        }))
    end
end

M.toggle_floating_centered = function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    hl.dispatch(hl.dsp.window.center())
    hl.dispatch(hl.dsp.window.resize({ x = 1250, y = 720 }))
end

M.toggle_statusbar = function()
    hl.dispatch(hl.dsp.exec_cmd("usr-statusbar-toggle " .. hl.get_active_monitor().id))
end

return M
