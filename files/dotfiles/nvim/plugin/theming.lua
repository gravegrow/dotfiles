local colorscheme = "zenbones"
-- stylua: ignore

---@class Colors
local  colors_dark = {
    dark    = "#121111",
    gray    = "#4f4f59",
    light   = "#B4BDC3",
    line    = "#212021",
    linealt = "#242324",
    visual  = "#1F1F22",
    recording  = "#301d20",
}

---@param colors Colors
local function SetHiglights(colors)
    local highlights = {
        Normal = { bg = "none" },
        NormalAlt = { bg = colors.dark },
        Visual = { bg = colors.visual },
        SignColumn = { bg = "none" },
        Comment = { fg = colors.gray, italic = true },
        MatchParen = { fg = colors.light, bold = true, bg = "none" },
        Search = { bg = colors.visual },
        IncSearch = { bg = colors.line, fg = colors.light, underline = true },

        NormalFloat = { bg = "none" },
        FloatBorder = { fg = colors.light, bg = "none" },
        -- FloatTitle = { link = "Boolean", bold = true },

        WhichKeyNormal = { bg = colors.dark },

        Statusline = { bg = colors.dark },
        StatuslineNC = { bg = colors.dark },
        StatuslineText = { fg = colors.light, bold = true },

        SnacksPickerDir = { link = "Comment" },

        Pmenu = { bg = colors.dark },
        Cursorline = { bg = colors.line },
        CursorlineDefault = { bg = colors.line },
        CursorlineRecording = { bg = colors.recording },
        CursorlineNr = { link = "String", bold = true },

        DiagnosticUnnecessary = { fg = colors.gray },

        BlinkCmpMenu = { bg = colors.dark },
        BlinkCmpMenuSelection = { bg = colors.linealt },
        BlinkCmpScrollBarThumb = { link = "@variable.builtin" },
        BlinkCmpScrollBarGutter = { bg = colors.dark },
        BlinkCmpLabelDeprecated = { link = "Comment", strikethrough = true },

        BlinkCmpKindEnum = { link = "@lsp.type.enum", bg = colors.visual },
        BlinkCmpKindFile = { link = "@variable.builtin", bg = colors.visual },
        BlinkCmpKindText = { fg = colors.light, bg = colors.visual },
        BlinkCmpKindUnit = { link = "@variable.builtin", bg = colors.visual },
        BlinkCmpKindClass = { link = "@lsp.type.class", bg = colors.visual },
        BlinkCmpKindColor = { link = "Error", bg = colors.visual },
        BlinkCmpKindEvent = { link = "@lsp.type.event", bg = colors.visual },
        BlinkCmpKindField = { link = "Identifier", bg = colors.visual },
        BlinkCmpKindValue = { link = "@constant", bg = colors.visual },
        BlinkCmpKindFolder = { link = "@character", bg = colors.visual },
        BlinkCmpKindMethod = { link = "@lsp.type.method", bg = colors.visual },
        BlinkCmpKindModule = { link = "@module", bg = colors.visual },
        BlinkCmpKindStruct = { link = "@lsp.type.struct", bg = colors.visual },
        BlinkCmpKindKeyword = { link = "@keyword", bg = colors.visual },
        BlinkCmpKindSnippet = { link = "@function.builtin", bg = colors.visual },
        BlinkCmpKindConstant = { link = "@constant", bg = colors.visual },
        BlinkCmpKindFunction = { link = "@function", bg = colors.visual },
        BlinkCmpKindOperator = { link = "@operator", bg = colors.visual },
        BlinkCmpKindProperty = { link = "@property", bg = colors.visual },
        BlinkCmpKindVariable = { link = "@variable", bg = colors.visual },
        BlinkCmpKindInterface = { link = "@lsp.type.interface", bg = colors.visual },
        BlinkCmpKindReference = { link = "@property", bg = colors.visual },
        BlinkCmpKindEnumMember = { link = "@lsp.type.enumMember", bg = colors.visual },
        BlinkCmpKindConstructor = { link = "@constructor", bg = colors.visual },
        BlinkCmpKindTypeParameter = { link = "@lsp.type.parameter", bg = colors.visual },
    }

    for name, opts in pairs(highlights) do
        _G.merge_set_hl(name, opts)
    end
end

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("ColorschemeUpdate", { clear = true }),
    callback = function()
        SetHiglights(colors_dark)
    end,
})

--- @param name string Highlight group name, e.g. "ErrorMsg"
--- @param opts vim.api.keyset.highlight Highlight definition map, accepts the following keys:
_G.merge_set_hl = function(name, opts)
    local source_opts = vim.api.nvim_get_hl(0, { name = name, create = true, link = false })
    if opts.link then
        source_opts = vim.api.nvim_get_hl(0, { name = opts.link, create = true, link = false })
        opts.link = nil
    end
    vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", source_opts, opts))
end

vim.cmd.colorscheme(colorscheme)
