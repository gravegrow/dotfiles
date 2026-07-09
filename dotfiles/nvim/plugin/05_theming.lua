local palette = {
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

for name, color in pairs(palette) do
    for _, prefix in ipairs({ "ui_fg", "ui_bg" }) do
        vim.api.nvim_set_hl(0, prefix .. "_" .. name, { fg = color })
    end
end

local diag_hl = {
    ["DiagnosticSignError"] = palette.color1,
    ["DiagnosticSignWarn"] = palette.color3,
    ["DiagnosticSignHint"] = palette.foreground,
    ["DiagnosticSignInfo"] = palette.color6,
}

for hl, color in pairs(diag_hl) do
    vim.api.nvim_set_hl(0, hl, { fg = color, bold = true })
end
