-- stylua: ignore
local colors_dark = {
  text       = "#b8b0ad",
  search     = "#C5C9C5",
  non_text   = "#272830",
  comment    = "#4f4f59",
  float      = "#0b0b0c",
  background = "#161617",
  cursorline = "#1A1A1C",
  statusline = "#1f1f22",
}

local function SetHiglights(palette)
  local highlights = {
    Normal = { fg = palette.text, bg = palette.background },
    Visual = { bg = palette.statusline },
    Comment = { fg = palette.comment },

    NormalFloat = { bg = palette.float },
    FloatBorder = { fg = palette.float, bg = palette.float },
    FloatTitle = { link = "Boolean", bg = palette.statusline, bold = true },

    CursorLine = { bg = palette.cursorline },
    CursorLineNr = { fg = palette.text, bg = "none", bold = true },
    CursorLineSign = { bg = "none" },
    CursorLineDefault = { bg = palette.cursorline },
    CursorLineRecording = { bg = "#301d20" },

    StatusLine = { fg = palette.text, bg = palette.statusline },
    StatusLineNC = { fg = palette.text, bg = palette.statusline },
    WinSeparator = { fg = palette.float, bg = palette.float },
    Folded = { bg = palette.statusline },

    LineNr = { link = "Comment", bg = "none", italic = false },
    NonText = { fg = palette.non_text },
    SignColumn = { bg = "none" },
    Colorcolumn = { bg = palette.float },

    CurSearch = { fg = palette.search, bg = palette.statusline, bold = true, underline = true },
    IncSearch = { link = "CurSearch" },
    Substitute = { link = "CurSearch" },

    DiagnosticUnnecessary = { undercurl = false },

    SnacksPicker = { bg = palette.float },
    SnacksPickerList = { bg = palette.float },
    SnacksPickerBoxBorder = { fg = palette.float, bg = palette.float },
    SnacksPickerBorder = { fg = palette.float, bg = palette.float },
    SnacksPickerInput = { bg = palette.statusline },
    SnacksPickerInputBorder = { fg = palette.statusline, bg = palette.statusline },
    SnacksPickerPreview = { bg = palette.float },
    SnacksPickerPreviewBorder = { bg = palette.float, fg = palette.statusline },
    SnacksPickerTree = { link = "NonText" },
    SnacksPickerDir = { link = "Comment" },
    SnacksPickerPrompt = { bg = palette.statusline },
    SnacksPickerGitStatusUntracked = { link = "Comment" },
    SnacksPickerTotals = { link = "Comment", bg = palette.statusline },
    SnacksPickerCursorLine = { link = "CursorLine" },
    SnacksPickerListCursorLine = { link = "CursorLine" },

    BlinkCmpMenu = { bg = palette.float },
    BlinkCmpMenuSelection = { bg = palette.cursorline },
    BlinkCmpScrollBarThumb = { bg = "#858EA2" },
    BlinkCmpScrollBarGutter = { bg = palette.float },

    MiniFilesTitle = { fg = palette.float, bg = palette.float },
    MiniFilesBorderModified = { link = "WarningMsg", bg = palette.float },

    ["@string.documentation.python"] = { link = "Comment" },
  }

  local hipatterns = {
    MiniHipatternsFixme = { fg = palette.background, bg = "#945B5B", bold = true },
    MiniHipatternsHack = { fg = palette.background, bg = "#B7927B", bold = true },
    MiniHipatternsTodo = { fg = palette.background, bg = "#627691", bold = true },
    MiniHipatternsNote = { fg = palette.background, bg = "#8EA4A2", bold = true },
  }

  for name, opts in pairs(hipatterns) do
    local border_name = name .. "Border"
    local border_opts = { fg = opts.bg, bg = opts.fg }
    highlights[name] = opts
    highlights[border_name] = border_opts
  end

  for name, opts in pairs(highlights) do
    local source_opts = vim.api.nvim_get_hl(0, { name = name, create = true, link = false })
    if opts.link then
      source_opts = vim.api.nvim_get_hl(0, { name = opts.link, create = true, link = false })
      opts.link = nil
    end
    vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", source_opts, opts))
  end
end

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

vim.cmd.hi("clear")
vim.cmd.colorscheme("habamax")
