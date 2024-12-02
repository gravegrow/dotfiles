-- stylua: ignore
local colors = {
  text       = "#b8b0ad",
  base       = "#161617",

  statusline = "#1f1f22",
  cursorline = "#1A1A1C",

  floatBorder = "#878787",
  line        = "#282830",
  comment     = "#646477",
  builtin     = "#bad1ce",
  func        = "#be8c8c",
  string      = "#deb896",
  number      = "#d2a374",
  property    = "#c7c7d4",
  constant    = "#b4b4ce",
  parameter   = "#b9a3ba",
  visual      = "#363738",
  error       = "#d2788c",
  warning     = "#e6be8c",
  hint        = "#8ca0dc",
  operator    = "#96a3b2",
  keyword     = "#7894ab",
  type        = "#a1b3b9",
  search      = "#465362",
  plus        = "#8faf77",
  delta       = "#e6be8c",
}

vim.cmd.hi("clear")
vim.cmd.colorscheme("habamax")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "undotree", "qf", "help" },
  group = vim.api.nvim_create_augroup("util-window-style", { clear = true }),
  callback = function()
    vim.cmd("set winhighlight=Normal:NormalFloat")
    vim.opt_local.colorcolumn = {}
  end,
})

local function set_hl(name, opts)
  local source_opts = vim.api.nvim_get_hl(0, { name = name, create = true, link = false })
  vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", source_opts, opts))
end

local hl = {}

local editor = {
  Normal = { fg = colors.text, bg = colors.base },
  CursorLine = { bg = colors.cursorline },
}

-- for name, opts in pairs(editor) do
--   set_hl(name, opts)
-- end
