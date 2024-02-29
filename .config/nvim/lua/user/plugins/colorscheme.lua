---@param name string
---@return vim.api.keyset.hl_info
local function get_hl(name) return vim.api.nvim_get_hl(0, { name = name }) end

---@param name string
---@param opts vim.api.keyset.highlight
local function set_hl(name, opts) return vim.api.nvim_set_hl(0, name, opts) end

---@param name string
---@param opts vim.api.keyset.highlight
local function override_hl(name, opts) set_hl(name, vim.tbl_extend('force', get_hl(name), opts)) end

---@param colors CtpColors<string>
---@param background string|nil
local function apply_custom_highlights(colors, background)
  background = background or colors.base

  override_hl('Normal', { bg = background })
  override_hl('NormalNC', { bg = background })
  set_hl('SignColumn', { fg = colors.peach, bold = true })

  set_hl('FloatBorder', { fg = colors.mantle, bg = colors.mantle })
  override_hl('Pmenu', { bg = colors.mantle })

  set_hl('CursorLineNr', { fg = colors.peach, bold = true })
  override_hl('CursorLine', { bold = true })

  override_hl('CmpDocBorder', { bg = colors.crust })
  set_hl('CmpDocBorder', { fg = colors.crust, bg = colors.crust })

  override_hl('TelescopeNormal', { bg = colors.mantle })
  set_hl('TelescopeTitle', { fg = colors.crust, bg = colors.lavender })

  set_hl('TelescopePreviewNormal', { bg = colors.base })
  set_hl('TelescopePreviewBorder', { fg = colors.lavender })
  set_hl('TelescopePreviewTitle', { bg = colors.lavender, fg = colors.crust })

  set_hl('TelescopePromptBorder', { bg = colors.crust, fg = colors.crust })
  override_hl('TelescopePromptNormal', { bg = colors.crust })
end

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = 'mocha',
    integrations = {
      mini = {
        enabled = true,
      },
      fidget = true,
      mason = true,
      lsp_trouble = true,
    },
  },
  config = function(_, opts)
    local pallete = require('catppuccin.palettes').get_palette(opts.flavour)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme 'catppuccin'

    apply_custom_highlights(pallete, '#1e1e2e')
  end,
}
