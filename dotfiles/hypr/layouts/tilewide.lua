local state = {
    mfact = 0.60,
    nmaster = 1,
}

local function clamp(x, min, max)
    return math.max(min, math.min(max, x))
end

hl.layout.register("tilewide", {
    recalculate = function(ctx)
        local n = #ctx.targets
        if n == 0 then
            return
        end

        if n == 1 then
            ctx.targets[1]:place(ctx.area)
            return
        end

        local active_masters = math.min(n - 1, state.nmaster)
        local total_slaves = n - active_masters

        state.nmaster = clamp(state.nmaster, 1, n - 1)

        if state.nmaster > 2 then
            state.mfact = 1 - (1 / (state.nmaster + 1))
        end

        local master_area = ctx:split(ctx.area, "left", state.mfact)
        local slave_area = ctx:split(ctx.area, "right", 1 - state.mfact)
        --
        ctx.area = master_area
        for i = 1, active_masters do
            local master_box = ctx:column(i, active_masters)
            ctx.targets[i]:place(master_box)
        end

        ctx.area = slave_area
        for i = (active_masters + 1), n do
            local slave_index = i - active_masters
            local slave_box = ctx:row(slave_index, total_slaves)
            ctx.targets[i]:place(slave_box)
        end
    end,

    layout_msg = function(ctx, msg)
        local command, arg = msg:match("^(%S+)%s*(.*)$")
        local num_clients = #ctx.targets

        hl.notification.create({
            text = command .. " | " .. arg,
            timeout = 4000,
        })

        if command == "mfact" then
            state.mfact = clamp(state.mfact + tonumber(arg), 0.1, 0.9)
        elseif command == "incnmaster" then
            state.nmaster = clamp(state.nmaster + tonumber(arg), 1, #ctx.targets - 1)
            state.mfact = 1 - (1 / (state.nmaster + 1))
        elseif command == "cyclenext" then
            hl.dispatch(hl.dsp.window.cycle_next({ next = true, tiled = true }))
        elseif command == "cycleprev" then
            hl.dispatch(hl.dsp.window.cycle_next({ next = false, tiled = true }))
        elseif command == "resizearg" or msg:find("resize") then
            local delta = tonumber(arg)
            if delta then
                state.mfact = math.max(0.15, math.min(0.85, state.mfact + delta))
            end
        end

        return true
    end,
})
