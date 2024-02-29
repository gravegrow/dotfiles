local M = {}

function M.apply_custom_highlights()
  ---@param name string
  local function get_hl(name) return vim.api.nvim_get_hl(0, { name = name }) end
  ---
  ---@param name string
  ---@param opts vim.api.keyset.highlight
  local function set_hl(name, opts) return vim.api.nvim_set_hl(0, name, opts) end

  ---@param name string
  ---@param opts vim.api.keyset.highlight
  ---@return vim.api.keyset.highlight
  local function base_on(name, opts) return vim.tbl_extend('force', get_hl(name), opts) end

  set_hl('Normal', base_on('Normal', { bg = '#1e1e2e' }))
  set_hl('NormalNC', base_on('NormalNC', { bg = get_hl('Normal').bg }))
  set_hl('SignColumn', base_on('SignColumn', { bg = get_hl('Normal').bg }))

  set_hl('CursorLineNr', base_on('Number', { bold = true }))
  set_hl('CursorLine', base_on('CursorLine', { bold = true }))

  local normal_float = get_hl 'NormalFloat'
  local cursor_line = get_hl 'CursorLine'

  set_hl('FloatBorder', { fg = normal_float.bg, bg = normal_float.bg })
  set_hl('Pmenu', base_on('Pmenu', { bg = normal_float.bg }))

  set_hl('TelescopeNormal', base_on('TelescopeNormal', { bg = normal_float.bg }))

  set_hl('TelescopePreviewNormal', { bg = get_hl('Normal').bg })
  set_hl('TelescopePreviewBorder', { fg = get_hl('Number').fg })

  set_hl('TelescopeTitle', { fg = get_hl('Number').fg })
  set_hl('TelescopePromptTitle', base_on('Number', { reverse = true, bold = true }))
end

return M
