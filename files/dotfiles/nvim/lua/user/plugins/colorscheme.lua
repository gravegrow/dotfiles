return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    -- enabled = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        colors = {
          palette = {
            dragonBlack2 = "#1f1f22",
            dragonBlack3 = "#161617",
            dragonBlack4 = "#272830",
            dragonBlack5 = "#1A1A1C",
            dragonBlack6 = "#272830",
            dragonAsh = "#4f4f59",
            oldWhite = "#aca3a0",
          },
          theme = { all = { ui = { bg_gutter = "none" } } },
        },
        overrides = function(colors)
          local theme = colors.theme
          return {
            Normal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_p3 },
            Visual = { bg = theme.ui.bg_m1 },
            FloatTitle = { fg = theme.syn.constant, bg = theme.ui.bg_p1, bold = true },

            NormalFloat = { bg = theme.ui.bg_dim },
            FloatBorder = { fg = theme.ui.bg_m2, bg = theme.ui.bg_m2 },
            WinSeparator = { fg = theme.ui.bg_m1, bg = theme.ui.bg_p3 },

            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_m1 },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m2 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            StatusLine = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            StatusLineNC = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            ColorColumn = { bg = theme.ui.bg_m2 },
            LineNr = { fg = theme.syn.comment },
            CursorLineNr = { fg = theme.ui.fg_dim, bold = true },

            Search = { fg = "#FFFFFF", bg = theme.ui.bg_p1, bold = false, blend = 100 },
            CurSearch = { fg = "#FFFFFF", bg = "none", bold = true, underline = true },
            IncSearch = { link = "CurSearch" },

            ["@string.documentation"] = { fg = theme.syn.comment },

            TelescopeTitle = { fg = theme.syn.constant, bg = theme.ui.bg_p1, bold = true },
            TelescopePreviewTitle = { fg = theme.syn.string, bg = theme.ui.bg_p1, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_m1 },
            TelescopePromptCounter = { fg = theme.syn.comment },
            TelescopePromptBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_dim },
            TelescopeResultsBorder = { fg = theme.ui.bg_dim, bg = theme.ui.bg_dim },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = "#1A1A1C" },
            TelescopeSelectionCaret = { bg = "#1A1A1C", fg = theme.syn.string },

            RenderMarkdownCode = { bg = theme.ui.bg_m2 },
            RenderMarkdownBullet = { fg = "#627690" },
            RenderMarkdownInlineHighlight = { bg = "none", fg = theme.syn.operator, bold = true },

            RenderMarkdownH1Bg = { bg = "none", fg = "#807e96" },
            RenderMarkdownH2Bg = { bg = "none", fg = "#8EA4A2" },
            RenderMarkdownH3Bg = { bg = "none", fg = "#b6927b" },
            RenderMarkdownH4Bg = { bg = "none", fg = "#be8c8c" },
            RenderMarkdownH5Bg = { bg = "none", fg = "#945b5b" },
            RenderMarkdownH6Bg = { bg = "none", fg = "#627690" },

            ["@markup.heading.1"] = { fg = "#807e96" },
            ["@markup.heading.2"] = { fg = "#8EA4A2" },
            ["@markup.heading.3"] = { fg = "#b6927b" },
            ["@markup.heading.4"] = { fg = "#be8c8c" },
            ["@markup.heading.5"] = { fg = "#945b5b" },
            ["@markup.heading.6"] = { fg = "#627690" },

            ["@markup.list.markdown"] = { fg = "#627690" },
            ["@markup.link.label.markdown_inline"] = { fg = "#8ea4a2", underline = false },
            ["@markup.link.url.markdown_inline"] = { fg = "#627690", underline = true },

            CursorLineDefault = { bg = "#1A1A1C" },
            CursorLineRecording = { bg = "#301d20" },

            LspInlayHint = { fg = theme.syn.comment, italic = true },
            LspSignatureActiveParameter = { fg = theme.syn.constant, bold = true, underline = true },
            ["@lsp.type.macro.c"] = { link = "Constant" },

            NormalFloatSec = { link = "TelescopePreviewNormal" },
            FloatBorderSec = { fg = theme.syn.special1, bg = theme.ui.bg_m2 },
            FloatTitleSec = { link = "TelescopePreviewTitle" },

            BlinkCmpMenu = { link = "NormalFloatSec" },
            BlinkCmpMenuSelection = { bg = theme.ui.bg_p2 },
            CmpItemAbbr = { link = "CmpItemMenu" },
            BlinkCmpDocBorder = { link = "FloatBorderSec" },
            BlinkCmpDocSeparator = { bg = theme.ui.bg_p3, fg = theme.syn.comment },
            BlinkCmpScrollBarThumb = { bg = theme.syn.special1 },
            BlinkCmpLabelDescription = { link = "Comment" },
            CmpItemAbbrMatch = { fg = theme.syn.constant, bold = true },
            BlinkCmpLabelMatch = { fg = theme.syn.constant, bold = true },

            MiniFilesTitle = { fg = theme.ui.fg_dim, bg = theme.ui.bg_dim },
            MiniFilesTitleFocused = { fg = theme.syn.special1, bg = theme.ui.bg_dim },
            MiniFilesBorderModified = { fg = theme.syn.constant, bg = theme.ui.bg_m2 },
            MiniFilesBorder = { fg = theme.ui.bg_m2, bg = theme.ui.bg_m2 },

            MiniHipatternsFixme = { fg = theme.ui.bg, bg = "#945B5B" },
            MiniHipatternsHack = { fg = theme.ui.bg, bg = "#B7927B" },
            MiniHipatternsTodo = { fg = theme.ui.bg, bg = "#627691" },
            MiniHipatternsNote = { fg = theme.ui.bg, bg = "#8EA4A2" },
          }
        end,
        background = {
          dark = "dragon",
          light = "lotus",
        },
      })

      vim.cmd.colorscheme("kanagawa")
    end,
  },
}
