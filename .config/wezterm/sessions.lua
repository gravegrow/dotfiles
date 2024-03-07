local wezterm = require('wezterm')

local projects = {
    '/media/storage/development/python',
    '/media/storage/development/godot',
}

---@class Sessions
local M = {}

---@return Sessions
function M.setup(config)
    local paths = ''

    local cmd = { 'find', '-mindepth', '1', '-maxdepth', '1', '-type', 'd' }

    for _, project in ipairs(projects) do
        table.insert(cmd, 2, project)
    end

    local success, stdout, stderr = wezterm.run_child_process(cmd)
    wezterm.log_info('PATHS: ' .. paths)
    wezterm.log_info('RESULT: ' .. stdout)
    wezterm.log_info('ERROR: ' .. stderr)
    return M
end

return M
