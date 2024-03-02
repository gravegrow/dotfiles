local M = {}

M.plugin = {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = 'mocha',
    integrations = {
      mini = { enabled = true },
      mason = true,
      lsp_trouble = true,
    },
  },
  config = function(_, opts)
    -- opts.color_overrides = { all = M.catbox_material }
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme 'catppuccin'

    M.apply_overrides(require('catppuccin.palettes').get_palette(opts.flavour))
  end,
}

---@return vim.api.keyset.hl_info
local function get_hl(name) return vim.api.nvim_get_hl(0, { name = name }) end
local function set_hl(name, opts) return vim.api.nvim_set_hl(0, name, opts) end
local function override_hl(name, opts) set_hl(name, vim.tbl_extend('force', get_hl(name), opts)) end

---@param colors CtpColors<string>
function M.apply_overrides(colors)
  override_hl('Normal', { bg = nil })
  override_hl('NormalNC', { bg = nil })
  set_hl('SignColumn', { fg = colors.peach, bold = true })

  override_hl('MsgArea', { bg = colors.mantle })

  set_hl('FloatBorder', { fg = colors.mantle, bg = colors.mantle })
  set_hl('FloatTitle', { bg = colors.rosewater, fg = colors.mantle, bold = true })

  override_hl('NormalFloat', { bg = colors.mantle })
  override_hl('Pmenu', { bg = colors.mantle })

  set_hl('CursorLineNr', { fg = colors.peach, bold = true })
  override_hl('CursorLine', { bold = true })

  set_hl('CmpDoc', { bg = colors.crust })
  set_hl('CmpDocBorder', { fg = colors.crust, bg = colors.crust })

  override_hl('TelescopeNormal', { bg = colors.mantle })
  set_hl('TelescopeTitle', { fg = colors.crust, bg = colors.lavender, bold = true })

  set_hl('TelescopePreviewNormal', { bg = colors.base })
  set_hl('TelescopePreviewBorder', { fg = colors.lavender })
  set_hl('TelescopePreviewTitle', { fg = colors.lavender, bg = colors.base, bold = true })

  set_hl('TelescopePromptBorder', { bg = colors.crust, fg = colors.crust })
  override_hl('TelescopePromptNormal', { bg = colors.crust })

  set_hl('DiagnosticVirtualTextError', { bg = nil, fg = get_hl('DiagnosticVirtualTextError').fg })

  set_hl('MacroRecording', { fg = colors.red, bold = true })

  set_hl('MiniStatusListIcon', { fg = colors.mantle, bg = colors.peach })
  set_hl('MiniStatusBlock', { fg = colors.text, bg = colors.mantle, bold = true })

  set_hl('MiniStatuslineFilename', { fg = colors.surface1, bg = colors.crust })

  set_hl('MiniFilesTitle', { fg = colors.surface1, bg = colors.mantle })
  set_hl('MiniFilesTitleFocused', { fg = colors.rosewater, bg = colors.mantle, bold = true })

  for _, diag in ipairs({ 'Error', 'Ok', 'Hint', 'Info', 'Warn' }) do
    local hl = 'Diagnostic' .. diag
    set_hl('DiagnosticUnderline' .. diag, { fg = get_hl(hl).fg, bold = true, italic = true })

    set_hl('MiniStatus' .. diag, { fg = get_hl(hl).fg, bg = colors.crust })
  end
end

M.catbox_material = {
  base = '#1D2021',
  blue = '#89B482',
  crust = '#141617',
  flamingo = '#EF9F76',
  green = '#A9B665',
  lavender = '#7DAEA3',
  mantle = '#191919',
  maroon = '#eba0ac',
  mauve = '#EA6962',
  overlay0 = '#504945',
  overlay1 = '#D4BE98',
  overlay2 = '#D4BE98',
  peach = '#EF9F76',
  pink = '#f5c2e7',
  red = '#EA6962',
  rosewater = '#f5e0dc',
  sapphire = '#A9B665',
  sky = '#E78A4E',
  subtext0 = '#a6adc8',
  subtext1 = '#bac2de',
  surface0 = '#282828',
  surface1 = '#3c3836',
  surface2 = '#504945',
  teal = '#94e2d5',
  text = '#D4BE98',
  yellow = '#D8A657',
}

return M.plugin
