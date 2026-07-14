local colors = {
    foreground = "#9A8F8A",
    background = "#101010",

    color0 = "#0A0A0A",
    color1 = "#945B5B",
    color2 = "#737c73",
    color3 = "#B7927B",
    color4 = "#627691",
    color5 = "#be8c8c",
    color6 = "#8EA4A2",
    color7 = "#696563",

    color8 = "#474747",
    color9 = "#9c6363",
    color10 = "#8f9d85",
    color11 = "#b99b88",
    color12 = "#6e7f96",
    color13 = "#baa0a7",
    color14 = "#98a9a7",
    color15 = "#9A8F8A",
}

_G.ui_colors = colors
_G.merge_set_hl = function(name, opts)
    if opts.override then
        opts.override = nil
        vim.api.nvim_set_hl(0, name, opts)
        return
    end

    local source_opts = vim.api.nvim_get_hl(0, { name = name, create = true, link = false })
    if opts.link then
        source_opts = vim.api.nvim_get_hl(0, { name = opts.link, create = true, link = false })
        opts.link = nil
    end
    vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", source_opts, opts))
end

for name, color in pairs(colors) do
    vim.api.nvim_set_hl(0, string.format("ui_%s_%s", "fg", name), { fg = color })
    vim.api.nvim_set_hl(0, string.format("ui_%s_%s", "bg", name), { bg = color, fg = colors.color0 })
end

local highligts = {
    StatusLine = { fg = colors.foreground, bg = colors.color0 },
    StatusLineNC = { bg = colors.color0 },
    StatusLineFg = { fg = colors.foreground },
    StatusLineFgAlt = { fg = colors.color8, italic = true },
    NormalFloat = { link = "Normal" },
    FloatBorder = { link = "Keyword" },
    PmenuSel = { bg = colors.color0, override = true },
    GitSignsAddLn = { link = "Added" },
    GitSignsAddPreview = { link = "Added" },
    GitSignsDeleteLn = { link = "Removed" },
    GitSignsDeletePreview = { link = "Removed" },
    FloatTitle = { bold = true },
    MoreMsg = { fg = colors.color4, bold = true },
    Question = { fg = colors.color4, bold = true },
    QuickFixLine = { fg = nil, bg = colors.color0, bold = true, override = true },
}

local diag_colors = {
    Error = colors.color9,
    Warn = colors.color3,
    Hint = colors.foreground,
    Info = colors.color6,
    Ok = colors.color10,
}

for _, type in ipairs({ "Error", "Warn", "Info", "Hint", "Ok" }) do
    local color = diag_colors[type]
    highligts["Diagnostic" .. type] = { fg = color }
    highligts["DiagnosticVirtualText" .. type] = { fg = color, bg = nil, bold = false, italic = true, override = true }
    highligts["DiagnosticUnderline" .. type] = { sp = color, underline = type ~= "Hint", undercurl = false }
end

local apply_highlights = function()
    for hl, opts in pairs(highligts) do
        merge_set_hl(hl, opts)
    end
end

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("ColorschemeUpdate", { clear = true }),
    callback = function()
        apply_highlights()
    end,
})
