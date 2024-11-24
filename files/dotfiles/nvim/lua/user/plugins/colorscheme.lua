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
        -- Default options:
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          palette = {
            dragonBlack2 = "#1f1f22",
            dragonBlack3 = "#161617",
            dragonBlack4 = "#272830",
            dragonBlack5 = "#272830",
            dragonBlack6 = "#272830",
            dragonAsh = "#4f4f59",
            oldWhite = "#aca3a0",
          },
          theme = { all = {
            ui = {
              bg_gutter = "none",
            },
          } },
        },
        overrides = function(colors)
          local theme = colors.theme
          return {
            Normal = { fg = "", bg = theme.ui.bg_p3 },
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
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

            FloatBorder = { fg = theme.ui.bg_m3, bg = theme.ui.bg_m3 },
            WinSeparator = { fg = theme.ui.bg_m3, bg = theme.ui.bg_m3 },

            ["@string.documentation"] = { fg = theme.syn.comment },

            Search = { fg = "#FFFFFF", bg = theme.ui.bg_p1, bold = false, blend = 100 },
            CurSearch = { fg = "#FFFFFF", bg = "none", bold = true, underline = true },
            IncSearch = { link = "CurSearch" },

            RenderMarkdownCode = { bg = theme.ui.bg_m3 },

            RenderMarkdownH1Bg = { bg = "none", fg = theme.syn.statement },
            RenderMarkdownH2Bg = { bg = "none", fg = theme.syn.type },
            RenderMarkdownH3Bg = { bg = "none", fg = theme.syn.special1 },
            RenderMarkdownH4Bg = { bg = "none", fg = theme.syn.type },
            RenderMarkdownH5Bg = { bg = "none", fg = theme.syn.type },
            RenderMarkdownH6Bg = { bg = "none", fg = theme.syn.type },

            ["@markup.list.markdown"] = { fg = "#627690" },

            Underlined = { fg = theme.syn.type },
          }
        end,
        theme = "wave", -- Load "wave" theme when 'background' option is not set
        background = { -- map the value of 'background' option to a theme
          dark = "dragon", -- try "dragon" !
          light = "lotus",
        },
      })

      vim.cmd("colorscheme kanagawa")
    end,
  },
}
