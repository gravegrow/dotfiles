-- stylua: ignore
local colors_dark = {
  text       = "#b8b0ad",
  non_text   = "#272830",
  comment    = "#4f4f59",
  float      = "#12120F",
  background = "#161617",
  cursorline = "#1A1A1C",
  statusline = "#1f1f22",
}

local function SetHiglights(palette)
  local highlights = {
    Normal = { fg = palette.text, bg = palette.background },
    CursorLine = { bg = palette.cursorline },
    CursorLineDefault = { bg = palette.cursorline },
    CursorLineRecording = { bg = "#301d20" },

    NormalFloat = { bg = palette.float },
    FloatBorder = { fg = palette.float, bg = palette.float },

    NonText = { fg = palette.non_text },
    StatusLine = { bg = palette.statusline },

    SnacksPicker = { bg = palette.float },
    SnacksPickerBoxBorder = { fg = palette.float, bg = palette.float },
    SnacksPickerBorder = { fg = palette.float, bg = palette.float },
    SnacksPickerInput = { bg = palette.statusline },
    SnacksPickerInputBorder = { fg = palette.statusline, bg = palette.statusline },
    SnacksPickerPreview = { bg = palette.float },
    SnacksPickerPreviewBorder = { bg = palette.float, fg = palette.statusline },
    SnacksPickerTree = { link = "NonText" },
    SnacksPickerDir = { link = "Comment" },
    SnacksPickerGitStatusUntracked = { link = "Comment" },
    SnacksPickerTotals = { link = "LineNr" },
    SnacksPickerCursorLine = { link = "CursorLine" },
    SnacksPickerListCursorLine = { link = "CursorLine" },

    BlinkCmpMenu = { bg = palette.float },
    BlinkCmpMenuSelection = { bg = palette.cursorline },
    -- CmpItemAbbr = { link = "CmpItemMenu" },
    -- BlinkCmpDocBorder = { link = "FloatBorderSec" },
    -- BlinkCmpDocSeparator = { bg = theme.ui.bg_p3, fg = theme.syn.comment },
    -- BlinkCmpScrollBarThumb = { bg = theme.syn.special1 },
    -- BlinkCmpLabelDescription = { link = "Comment" },
    -- CmpItemAbbrMatch = { fg = theme.syn.constant, bold = true },
    -- BlinkCmpLabelMatch = { fg = theme.syn.constant, bold = true },
  }

  for name, opts in pairs(highlights) do
    local source_opts = vim.api.nvim_get_hl(0, { name = name, create = true, link = false })
    vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", source_opts, opts))
  end
end

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

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("colorscheme-update", { clear = true }),
  callback = function()
    if vim.o.background == "dark" then
      SetHiglights(colors_dark)
    else
      -- SetHiglights(colors_light)
    end
  end,
})
