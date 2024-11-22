local function set_hl(name, opts)
  local source_opts = vim.api.nvim_get_hl(0, { name = name, create = true, link = false })
  vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", source_opts, opts))
end

-- stylua: ignore
local palette = {
  bg     = "#161617",
  bg_one = "#1f1f22",
  bg_two = "#272830",
  text   = "#b3b8cc",
  gray   = "#4f4f59",
}

local hl = {}

hl.Normal = { fg = palette.text, bg = palette.bg }
hl.CursorLine = { bg = palette.bg_two }
hl.Comment = { fg = palette.gray }
hl.StatusLine = { fg = palette.text, bg = "#1F1F22" }

hl.Pmenu = { bg = palette.bg_one }
hl.PmenuSel = { link = "CursorLine" }

hl.NormalFloat = { bg = palette.bg_one }
hl.FloatBorder = { fg = palette.bg_one, bg = palette.bg_one }
hl.FloatTitle = { bg = palette.bg_two }

-- hl.TelescopeMatching = { fg = "love" }
hl.TelescopeNormal = { link = "NormalFloat" }
hl.TelescopeBorder = { link = "FloatBorder" }
hl.TelescopeTitle = { link = "FloatTitle" }
hl.TelescopePreviewNormal = { link = "TelescopeNormal" }
hl.TelescopePreviewBorder = { link = "TelescopeBorder" }
hl.TelescopeSelection = { link = "PmenuSel" }
-- hl.TelescopePreviewTitle = { bg = "overlay", fg = "overlay" }

for name, opts in pairs(hl) do
  set_hl(name, opts)
end
