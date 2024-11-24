-- stylua: ignore
local colors = {
  base       = "#161617",
  statusline = "#1f1f22",
  cursorline = "#272830",
  text       = "#b8b0ad",
  search     = "#dbd8d6",
  comment    = "#4f4f59",
  property   = "#C4B28A",
  string     = "#8A9A7B",
  constant   = "#B6927B",

  -- keyword   = "#807e96",
  -- func      = "#b8b0ad",
  -- builtin   = "#b8b0ad",
  -- bracket   = "#505362",
  -- parameter = "#b9a3ba",
  -- number    = "#d2a374",
  -- constant  = "#b4b4ce",
  -- operator  = "#96a3b2",
  -- type      = "#a1b3b9",

  purple = "#807e96",
  red    = "#945b5b",
  orange = "#B7927B",
  pink   = "#be8c8c",
  blue   = "#627691",
  green  = "#8EA4A2",


  error       = "#d2788c",
  warning     = "#e6be8c",
  hint        = "#8ca0dc",

  visual      = "#363738",
  plus        = "#8faf77",
  delta       = "#e6be8c",
}

vim.cmd.colorscheme("default")

local function set_hl(name, opts)
  local source_opts = vim.api.nvim_get_hl(0, { name = name, create = true, link = false })
  vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", source_opts, opts))
end

local hl = {}

hl.Normal = { fg = colors.text, bg = colors.base }
hl.WinSeparator = { fg = colors.statusline, bg = colors.statusline }
hl.CursorLine = { bg = colors.cursorline }
hl.StatusLine = { fg = colors.text, bg = colors.statusline }
hl.NonText = { fg = colors.cursorline }

hl.Comment = { fg = colors.comment, italic = true }
hl.String = { fg = colors.string }
hl.Constant = { fg = colors.constant }

hl["@property"] = { fg = colors.property }
hl["@variable.member"] = { link = "@property" }
hl["@lsp.type.property"] = { link = "@property" }

hl["@lsp.typemod.variable.global"] = { link = "Constant" }

hl.Search = { fg = colors.search, bg = colors.statusline }
hl.CurSearch = { fg = colors.search, bg = "none", bold = true, underline = true }

hl.Pmenu = { bg = colors.statusline }
hl.PmenuSel = { link = "CursorLine" }

hl.NormalFloat = { bg = colors.statusline }
hl.FloatBorder = { fg = colors.statusline, bg = colors.statusline }
hl.FloatTitle = { bg = colors.cursorline }

hl.NormalFloatSec = { bg = colors.cursorline }
hl.FloatBorderSec = { fg = colors.cursorline, bg = colors.cursorline }
hl.FloatTitleSec = { fg = colors.cursorline, bg = colors.cursorline }

hl.TelescopeMatching = { fg = colors.search, bold = true }
hl.TelescopeNormal = { link = "NormalFloat" }
hl.TelescopeBorder = { link = "FloatBorder" }
hl.TelescopeTitle = { link = "FloatTitle" }

hl.TelescopePreviewNormal = { link = "NormalFloatSec" }
hl.TelescopePreviewBorder = { link = "FloatBorderSec" }
hl.TelescopePreviewTitle = { link = "FloatTitleSec" }
hl.TelescopeSelection = { link = "PmenuSel" }

-- hl["@keyword.return"] = { fg =  }

-- for name, opts in pairs(hl) do
--   set_hl(name, opts)
-- end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "undotree", "qf", "help" },
  group = vim.api.nvim_create_augroup("util-window-style", { clear = true }),
  callback = function()
    vim.cmd("set winhighlight=Normal:NormalFloat")
    vim.opt_local.colorcolumn = {}
  end,
})
