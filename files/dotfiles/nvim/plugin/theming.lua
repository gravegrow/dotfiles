local colorscheme = "monoglow-lack"

-- stylua: ignore
---@class Colors
local colors_dark = {
    dark      = "#0A0A0A",
    gray      = "#2f2f2f",
    light     = "#CCCCCC",
    line      = "#1F1F1F",
    linealt   = "#1c1c1c",
    visual    = "#1F1F1f",
    darkgray1 = "#202020",
    darkgray2 = "#282828",
    recording = "#301d20",
    glow      = "#D27E99",
}

---@param colors Colors
local function SetHiglights(colors)
    local highlights = {
        Normal = { bg = "none" },
        Visual = { bg = colors.visual },
        Search = { bg = colors.visual },
        IncSearch = { bg = "none", fg = colors.light, underline = true, bold = true },

        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        -- FloatTitle = { link = "Boolean", bold = true },

        WhichKeyNormal = { bg = colors.dark },

        Statusline = { bg = "none" },
        StatuslineNC = { bg = "none" },
        StatuslineText = { fg = colors.light, bold = true },

        SnacksPickerDir = { link = "Comment" },
        SnacksPickerMatch = { fg = colors.glow, bold = true },
        SnacksIndent = { fg = colors.darkgray1 },
        SnacksIndentScope = { fg = colors.darkgray2 },

        Pmenu = { bg = colors.dark },
        Cursorline = { bg = colors.line },
        CursorlineDefault = { bg = colors.line },
        CursorlineRecording = { bg = colors.recording },
        CursorlineNr = { link = "Boolean", bold = true },

        DiagnosticDeprecated = { link = "Comment", strikethrough = true },
        DiagnosticUnnecessary = { fg = colors.gray },

        BlinkCmpMenu = { bg = colors.dark },
        BlinkCmpMenuSelection = { bg = colors.linealt },
        BlinkCmpScrollBarThumb = { bg = colors.visual },
        BlinkCmpScrollBarGutter = { bg = colors.dark },
        BlinkCmpLabelDeprecated = { link = "Comment", strikethrough = true },
        BlinkCmpLabelMatch = { fg = colors.glow, bold = true },

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

        RenderMarkdownH1Bg = { bg = "#201f23" },
        RenderMarkdownH2Bg = { bg = "#201f23" },
        RenderMarkdownH3Bg = { bg = "#201f23" },
        RenderMarkdownH4Bg = { bg = "#201f23" },
        RenderMarkdownH5Bg = { bg = "#201f23" },
        RenderMarkdownH6Bg = { bg = "#201f23" },
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

require("monoglow").setup({
    on_colors = function(colors)
        colors.glow = colors_dark.glow
    end,
})

vim.cmd.colorscheme(colorscheme)
