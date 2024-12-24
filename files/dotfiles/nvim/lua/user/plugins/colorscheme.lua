return {
  {
    "rose-pine/neovim",
    lazy = false,
    enabled = false,
    priority = 1000,
    name = "rose-pine",
    config = function()
      -- stylua: ignore
      local colors = {
        base              = "#161617",
        surface           = "#1f1f22",
        overlay           = "#272830",
        muted             = "#4f4f59",
        subtle            = "#626275",
        text              = "#aca3a0",
        love              = "#945b5b",
        gold              = "#b6927b",
        rose              = "#be8c8c",
        pine              = "#627691",
        foam              = "#8EA4A2",
        iris              = "#807e96",
        highlight_med     = "#272830",
        highlight         = "#dbd8d6",
      }

      require("rose-pine").setup({
        variant = "main",
        styles = { italic = false },
        palette = { main = colors },
        groups = {
          border = "surface",
          error = "#945b5b",
          warn = "#B7927B",
        },

        highlight_groups = {
          String = { italic = true },
          Constant = { fg = "text" },
          Comment = { italic = true, fg = "muted" },
          CursorLineNr = { fg = "iris" },
          FloatTitle = { bg = "overlay", fg = "text" },
          StatusLine = { bg = "surface", fg = "text" },
          WinSeparator = { link = "FloatBorder" },
          TelescopeMatching = { fg = "highlight" },
          TelescopeNormal = { bg = "surface" },
          TelescopeTitle = { link = "FloatTitle" },
          TelescopeSelection = { bg = "overlay", bold = true },
          TelescopePreviewNormal = { bg = "overlay" },
          TelescopePreviewBorder = { bg = "overlay", fg = "overlay" },
          TelescopePreviewTitle = { bg = "overlay", fg = "overlay" },
          MiniFilesBorderModified = { bg = "surface", fg = "gold" },
          TreesitterContext = { link = "NormalFloat" },
          TreesitterContextLineNumber = { link = "NormalFloat" },
          BqfPreviewFloat = { link = "TelescopePreviewNormal" },
          BqfPreviewBorder = { link = "TelescopePreviewBorder" },
          QuickFixLine = { fg = "gold" },
          PmenuSel = { bg = "overlay", bold = true, fg = "none" },
          Search = { fg = "highlight", bg = "overlay", bold = false, blend = 100 },
          CurSearch = { fg = "highlight", bg = "overlay", bold = true, underline = true },
          LspInlayHint = { blend = 0 },
          DapUIType = { fg = "foam", bold = true },
          LspSignatureActiveParameter = { bold = true, bg = "overlay" },
          CursorLine = { bg = "overlay" },
          CursorLineDefault = { bg = "overlay" },
          CursorLineRecording = { bg = "love", blend = 15 },
          Number = { fg = "pine" },

          CmpItemAbbrDefault = { fg = "text" },
          CmpItemAbbr = { fg = "text" },
          CmpItemAbbrMatch = { fg = "love" },
          CmpItemAbbrDeprecated = { fg = "muted" },
          CmpItemAbbrDeprecatedDefault = { link = "CmpItemAbbrDeprecated" },

          NoiceVirtualText = { link = "Comment" },
          Keyword = { bold = true },

          ["@keyword.operator"] = { bold = true },
          ["@variable.builtin"] = { bold = false },
          ["@type.builtin.python"] = { fg = "rose", italic = true },
          ["@markup.italic"] = { italic = true },
          ["@constructor.lua"] = { link = "@punctuation.bracket" },
          ["@punctuation.bracket"] = { bold = true },
          ["@constant"] = { link = "Constant" },
          ["@property"] = { fg = "iris" },
          ["@variable.member"] = { fg = "iris" },

          ColorColumn = { bg = "none", blend = 0 },

          RenderMarkdownH1Bg = { bg = "none", blend = 0 },
          RenderMarkdownH2Bg = { link = "RenderMarkdownH1Bg" },
          RenderMarkdownH3Bg = { link = "RenderMarkdownH1Bg" },
          RenderMarkdownH4Bg = { link = "RenderMarkdownH1Bg" },
          RenderMarkdownH5Bg = { link = "RenderMarkdownH1Bg" },
          RenderMarkdownH6Bg = { link = "RenderMarkdownH1Bg" },

          NormalFloatSec = { bg = colors.overlay },
          FloatBorderSec = { fg = colors.overlay, bg = colors.overlay },
          FloatTitleSec = { fg = colors.overlay, bg = colors.overlay },

          RenderMarkdownDash = { fg = "overlay" },
          RenderMarkdownCode = { link = "NormalFloat" },
        },
      })

      vim.g.set_separators_solid = function()
        vim.api.nvim_set_hl(0, "WinSeparator", { link = "FloatBorder" })
      end

      vim.g.set_separators_pretty = function()
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.surface, bg = colors.base })
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "undotree", "qf", "help" },
        group = vim.api.nvim_create_augroup("util-window-style", { clear = true }),
        callback = function()
          vim.cmd("set winhighlight=Normal:NormalFloat")
          vim.opt_local.colorcolumn = {}
        end,
      })

      vim.cmd.colorscheme("rose-pine")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    enabled = true,
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
            FloatTitle = { fg = theme.ui.special, bg = theme.ui.bg_p1, bold = true },

            MiniFilesTitle = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            MiniFilesTitleFocused = { fg = theme.syn.special1, bg = theme.ui.bg_m1 },

            TelescopeTitle = { fg = theme.ui.fg_dim, bg = theme.ui.bg_p1, bold = true },
            TelescopePreviewTitle = { fg = theme.ui.bg_dim, bg = theme.ui.bg_dim, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_m1 },
            TelescopePromptCounter = { fg = theme.syn.comment },
            TelescopePromptBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_m1 },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            StatusLine = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            LineNr = { fg = theme.syn.comment },
            CursorLineNr = { fg = theme.ui.fg_dim, bold = true },

            -- Identifier = { fg = theme.ui.fg_dim },
            -- ["@variable.member"] = { fg = theme.ui.fg_dim },

            NormalFloat = { bg = theme.ui.bg_m1 },
            FloatBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            WinSeparator = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },

            ["@string.documentation"] = { fg = theme.syn.comment },

            Search = { fg = "#FFFFFF", bg = theme.ui.bg_p1, bold = false, blend = 100 },
            CurSearch = { fg = "#FFFFFF", bg = "none", bold = true, underline = true },
            IncSearch = { link = "CurSearch" },

            RenderMarkdownCode = { bg = theme.ui.bg_m1 },
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

            MiniFilesBorderModified = { fg = theme.syn.constant, bg = theme.ui.bg_m1 },
            LspInlayHint = { fg = theme.syn.comment, italic = true },

            NormalFloatSec = { link = "TelescopePreviewNormal" },
            FloatBorderSec = { link = "TelescopePreviewBorder" },
            FloatTitleSec = { link = "TelescopePreviewTitle" },

            CmpItemAbbr = { link = "CmpItemMenu" },
            BlinkDoc = { link = "NormalFloatSec" },
            BlinkCmpDoc = { link = "NormalFloatSec" },
            BlinkCmpDocBorder = { link = "FloatBorderSec" },
            BlinkCmpDocSeparator = { bg = theme.ui.bg_dim, fg = theme.syn.comment },
            BlinkCmpScrollBarThumb = { bg = theme.syn.comment },
            BlinkCmpMenuSelection = { bg = theme.ui.bg_p1 },
            BlinkCmpLabelDescription = { fg = theme.syn.constant },
          }
        end,
        background = {
          dark = "dragon",
          light = "lotus",
        },
      })

      vim.cmd("colorscheme kanagawa")
    end,
  },
}
