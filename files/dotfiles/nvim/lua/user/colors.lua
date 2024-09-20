local UI = {
    fg = "#9e9794",
    bg = '#161617',
    bg_dark = '#020203',
    bg_light = '#252527',
}

local COLORS = {
    red    = "#af6a6a",
    green  = "#9cb380",
    orange = "#B7927B",
    yellow = "#C4B28A",
    blue   = "#809bb3",
    teal   = "#97B7B3",
    pink   = "#977b9f",
    purple = "#807E96",
}

local highlights = {
    Normal = { fg = UI.fg, bg = UI.bg, },
    NormalFloat = { fg = COLORS.purple, bg = UI.bg_light},
    MiniStatuslineNormal = {bg = UI.bg_dark}
}


for hl, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, hl, opts)
end
