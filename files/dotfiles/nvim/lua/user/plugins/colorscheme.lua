return {
  "rose-pine/neovim",
  lazy = false,
  priority = 1000,
  name = "rose-pine",
  config = function()
    -- stylua: ignore
    _G.ROSE_PINE_COLORS = {
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
      -- highlight_low  = "#272830",
      highlight_med     = "#272830",
      -- highlight_high = "#4a4950",
    }

    -- -- stylua: ignore
    -- _G.ROSE_PINE_COLORS = {
    --   base              = "#161617",
    --   surface           = "#1f1f22",
    --   overlay           = "#272830",
    --   muted             = "#4f4f59",
    --   subtle            = "#626275",
    --   text              = "#6e6e7f",
    --   love              = "#7b7b8a",
    --   gold              = "#888895",
    --   rose              = "#9595a0",
    --   pine              = "#a3a3ab",
    --   foam              = "#b0b0b6",
    --   iris              = "#bebec1",
    --   -- highlight_low  = "#272830",
    --   highlight_med     = "#272830",
    --   -- highlight_high = "#4a4950",
    -- }

    require("rose-pine").setup({
      variant = "main",
      styles = { italic = false },
      palette = { main = _G.ROSE_PINE_COLORS },
      groups = {
        border = "surface",
        error = "#945b5b",
        warn = "#B7927B",
      },

      highlight_groups = {
        Comment = { italic = true, fg = "muted" },
        CursorLineNr = { fg = "subtle" },
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

        CmpItemMenu = { fg = "muted", italic = true },
        CmpItemAbbrMatch = { fg = "love" },
        CmpItemAbbrDeprecated = { fg = "muted" },
        CmpItemAbbrDeprecatedDefault = { link = "CmpItemAbbrDeprecated" },

        NoiceVirtualText = { link = "Comment" },

        ["@keyword.operator"] = { bold = true },
        ["@type.builtin.python"] = { fg = "rose", italic = true },
        ["@markup.italic"] = { italic = true },
        ["@constructor.lua"] = { link = "@punctuation.bracket" },

        RenderMarkdownH1Bg = { bg = "none" },
        RenderMarkdownH2Bg = { bg = "none" },
        RenderMarkdownH3Bg = { bg = "none" },
        RenderMarkdownH4Bg = { bg = "none" },
        RenderMarkdownH5Bg = { bg = "none" },
        RenderMarkdownH6Bg = { bg = "none" },

        RenderMarkdownDash = { fg = "overlay" },
        RenderMarkdownCode = { link = "NormalFloat" },
        -- RenderMarkdownCodeInline = { bg = "none", blend = 30 },
      },
    })

    _G.set_separators_solid = function()
      vim.api.nvim_set_hl(0, "WinSeparator", { link = "FloatBorder" })
    end

    _G.set_separators_pretty = function()
      vim.api.nvim_set_hl(0, "WinSeparator", {
        fg = _G.ROSE_PINE_COLORS.surface,
        bg = _G.ROSE_PINE_COLORS.base,
      })
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "undotree", "qf", "help" },
      group = vim.api.nvim_create_augroup("util-window-style", { clear = true }),
      callback = function()
        vim.cmd "set winhighlight=Normal:NormalFloat"
      end,
    })

    vim.cmd.colorscheme "rose-pine"
  end,
}
