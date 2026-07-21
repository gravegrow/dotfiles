local state = {
    mfact = 0.66,
    nmaster = 1,
    targets = {},
    request_swap = false,
}

local function clamp(x, min, max)
    return math.max(min, math.min(max, x))
end

hl.layout.register("tilewide", {
    recalculate = function(ctx)
        local num_clients = #ctx.targets

        if num_clients == 0 then
            return
        end

        if num_clients == 1 then
            ctx.targets[1]:place(ctx.area)
            return
        end

        state.nmaster = clamp(state.nmaster, 1, num_clients - 1)

        local num_masters = math.min(num_clients - 1, state.nmaster)
        local num_slaves = num_clients - num_masters

        local master_area = ctx:split(ctx.area, "left", state.mfact)
        local slave_area = ctx:split(ctx.area, "right", 1 - state.mfact)

        ctx.area = master_area
        for i = 1, num_masters do
            local master_box = ctx:column(i, num_masters)
            ctx.targets[i]:place(master_box)
        end

        ctx.area = slave_area
        for i = 1, num_slaves do
            local slave_box = ctx:row(i, num_slaves)
            ctx.targets[i + num_masters]:place(slave_box)
        end
    end,

    layout_msg = function(ctx, msg)
        local command, arg = msg:match("^(%S+)%s*(.*)$")
        local targets = #ctx.targets
        local num_clients = #ctx.targets

        -- hl.notification.create({
        --     text = command .. " | " .. arg,
        --     timeout = 1000,
        -- })

        if command == "mfact" then
            state.mfact = clamp(state.mfact + tonumber(arg), 0.1, 0.9)
        elseif command == "incnmaster" then
            state.nmaster = state.nmaster + tonumber(arg)
        elseif command == "cyclenext" then
            hl.dispatch(hl.dsp.window.cycle_next({ next = true, tiled = true }))
        elseif command == "cycleprev" then
            hl.dispatch(hl.dsp.window.cycle_next({ next = false, tiled = true }))
        elseif command == "cycleprev" then
            hl.dispatch(hl.dsp.window.cycle_next({ next = false, tiled = true }))
        elseif command == "swapwithmaster" then
        end

        return true
    end,
})
