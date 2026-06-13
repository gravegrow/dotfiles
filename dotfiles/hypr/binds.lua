local Bind = {}

Bind.bind = function(keys, command)
    local sequence = ""
    for _, key in ipairs(keys) do
        sequence = sequence .. " + " .. key
    end
    return hl.bind(sequence, command)
end

Bind.run = function(keys, command)
    return Bind.bind(keys, hl.dsp.exec_cmd(command))
end

Bind.layout_msg = function(keys, msg)
    return Bind.bind(keys, hl.dsp.layout(msg))
end

return Bind
