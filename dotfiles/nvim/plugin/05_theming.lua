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
    local source_opts = vim.api.nvim_get_hl(0, { name = name, create = true, link = false })
    if opts.link then
        source_opts = vim.api.nvim_get_hl(0, { name = opts.link, create = true, link = false })
        opts.link = nil
    end
    vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", source_opts, opts))
end

for name, color in pairs(colors) do
    for _, prefix in ipairs({ "ui_fg", "ui_bg" }) do
        vim.api.nvim_set_hl(0, prefix .. "_" .. name, { fg = color })
    end
end

local diag_hl = {
    ["DiagnosticSignError"] = colors.color1,
    ["DiagnosticSignWarn"] = colors.color3,
    ["DiagnosticSignHint"] = colors.foreground,
    ["DiagnosticSignInfo"] = colors.color6,
}

for hl, color in pairs(diag_hl) do
    _G.merge_set_hl(hl, { fg = color, bold = true })
end
