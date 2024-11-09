return {
  "rose-pine/neovim",
  lazy = false,
  -- enabled = false,
  priority = 1000,
  name = "rose-pine",
  config = function()
    -- stylua: ignore
    local palette = {
      base              = "#161617",
      surface           = "#1f1f22",
      overlay           = "#272830",
      muted             = "#4f4f59",
      subtle            = "#626275",
      text              = "#9A8F8A",
      love              = "#945b5b",
      gold              = "#B7927B",
      rose              = "#be8c8c",
      pine              = "#627691",
      foam              = "#8EA4A2",
      iris              = "#807e96",
      highlight_med     = "#272830",
    }

    require("rose-pine").setup({
      variant = "main",
      styles = { italic = false },
      palette = { main = palette },
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
        WinSeparator = { link = "FloatBorder" },
        TelescopeMatching = { fg = "love" },
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
        Search = { blend = 100, bg = "overlay", fg = "love", bold = true },
        CurSearch = { fg = "love", bg = "overlay", bold = true, underline = true },
        LspInlayHint = { blend = 0 },
        DapUIType = { fg = "foam", bold = true },
        LspSignatureActiveParameter = { bold = true, bg = "overlay" },
        CursorLine = { bg = "overlay" },
        CursorLineDefault = { bg = "overlay" },
        CursorLineRecording = { bg = "love", blend = 15 },
        Number = { fg = "pine" },

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

        ColorColumn = { bg = "none", blend = 0 },

        RenderMarkdownH1Bg = { bg = "none", blend = 0 },
        RenderMarkdownH2Bg = { link = "RenderMarkdownH1Bg" },
        RenderMarkdownH3Bg = { link = "RenderMarkdownH1Bg" },
        RenderMarkdownH4Bg = { link = "RenderMarkdownH1Bg" },
        RenderMarkdownH5Bg = { link = "RenderMarkdownH1Bg" },
        RenderMarkdownH6Bg = { link = "RenderMarkdownH1Bg" },

        RenderMarkdownDash = { fg = "overlay" },
        RenderMarkdownCode = { link = "NormalFloat" },
      },
    })

    _G.set_separators_solid = function()
      vim.api.nvim_set_hl(0, "WinSeparator", { link = "FloatBorder" })
    end

    _G.set_separators_pretty = function()
      vim.api.nvim_set_hl(0, "WinSeparator", {
        fg = palette.surface,
        bg = palette.base,
      })
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "undotree", "qf", "help" },
      group = vim.api.nvim_create_augroup("util-window-style", { clear = true }),
      callback = function()
        vim.cmd "set winhighlight=Normal:NormalFloat"
        vim.opt_local.colorcolumn = {}
      end,
    })

    vim.cmd.colorscheme "rose-pine"
  end,
}
