local M = {}
local icons = require("core.ui").icons

M.default_icon = {
  function()
    return icons.page
  end,
  cond = function()
    return vim.bo.filetype == ""
  end,
}

M.diagnostics = {
  "diagnostics",
  source = { "nvim" },
  symbols = {
    error = icons.error,
    warn = icons.warning,
    hint = icons.hint,
    info = icons.info,
  },
}

M.filetype_icon = {
  "filetype",
  colored = false,
  icon_only = true,
}

M.cursor = {
  "%l:%c | %L",
  cond = function()
    return vim.fn.winwidth(0) > 60
  end,
  icon = { icons.list },
}

M.diff = {
  "diff",
  symbols = {
    added = icons.added,
    modified = icons.modified,
    removed = icons.removed,
  },
  cond = function()
    return vim.fn.winwidth(0) > 80
  end,
}
M.filename = {
  "filename",
  file_status = false,
  path = 1,
  icon = { icons.folder },
  cond = function()
    return vim.fn.winwidth(0) > 40
  end,
}

M.fileformat = {
  "fileformat",
  icons_enabled = true,
  symbols = {
    unix = "unix",
    dos = "dos",
    mac = "mac",
  },
  cond = function()
    return vim.fn.winwidth(0) > 90
  end,
}

M.branch = {
  "branch",
  icon = { icons.branch },
  color = { gui = "bold" },
}

M.mode = {
  "mode",
}

M.separator = {
  function()
    return " "
  end,
  padding = { right = -1 },
}

M.macro = {
  function()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
      return ""
    end

    return "REC @" .. recording_register
  end,
  icon = { icons.circle },
}

M.opts = {
  options = {
    component_separators = { left = "|", right = "|" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { M.default_icon, M.filetype_icon },
    lualine_b = { M.mode, M.separator, M.macro, M.diagnostics },
    lualine_c = { M.filename, M.fileformat },
    lualine_x = {},
    lualine_y = { M.diff, M.separator, M.branch },
    lualine_z = { M.separator, M.cursor },
  },
}

return {
  "nvim-lualine/lualine.nvim",
  event = "UIEnter",
  config = function()
    local theme = require "lualine.themes.auto"
    local colors = require("catppuccin.palettes").get_palette "mocha"

    M.separator.color = { bg = colors.crust }

    M.branch.color = { bg = colors.mantle, fg = colors.green, gui = "bold" }
    M.branch.icon.color = { fg = colors.mantle, bg = colors.green }

    M.cursor.color = { fg = colors.peach, bg = colors.mantle }
    M.cursor.icon.color = { bg = colors.peach, fg = colors.mantle }

    M.mode.color = { bg = colors.mantle, gui = "bold" }
    M.diagnostics.color = { bg = colors.mantle }

    M.macro.icon.color = { bg = colors.red, fg = colors.mantle, gui = "bold" }
    M.macro.color = { fg = colors.red, bg = colors.mantle, gui = "bold" }

    M.diff.color = { bg = colors.mantle }

    theme.normal.c.bg = colors.crust
    theme.normal.c.fg = colors.surface0

    theme.insert.a.bg = colors.teal
    theme.insert.b.fg = theme.insert.a.bg

    theme.normal.a.bg = colors.lavender
    theme.normal.b.fg = theme.normal.a.bg

    theme.visual.a.bg = colors.maroon
    theme.visual.b.fg = theme.visual.a.bg

    M.opts.options.theme = theme
    require("lualine").setup(M.opts)

    vim.api.nvim_create_autocmd({ "RecordingLeave", "RecordingEnter" }, {
      group = vim.api.nvim_create_augroup("Recording", { clear = true }),
      callback = function()
        require("lualine").refresh()
      end,
    })
  end,
}
