-- print(vim.inspect(require("catppuccin.palettes").get_palette "mocha"))
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = true,
    priority = 1000,
    opts = {
      flavour = "mocha",
      integrations = {
        native_lsp = {
          enabled = true,
          underlines = {
            errors = {},
            hints = {},
            warnings = {},
            information = {},
          },
        },
      },
      custom_highlights = function(colors)
        return {
          -- FloatBorder = { fg = colors.mantle, bg = colors.mantle },
          SagaNormal = { bg = colors.base },
          SagaBorder = { fg = colors.blue },
          CodeActionNumber = { bg = colors.mantle, fg = colors.yellow, style = { "bold" } },

          MsgArea = { fg = colors.text, bg = colors.crust },
          CursorLine = { style = { "bold" } },
          NvimTreeIndentMarker = { fg = colors.surface1 },

          NvimTreeOpenedFolderName = { fg = colors.peach, style = { "bold" } },
          NvimTreeFolderName = { fg = colors.peach },
          NvimTreeFolderIcon = { fg = colors.peach },

          TelescopeSelection = { bg = colors.surface0, style = { "bold" } },

          TelescopePromptNormal = { bg = colors.crust },
          TelescopePromptBorder = { fg = colors.crust, bg = colors.crust },
          TelescopePromptTitle = { bg = colors.red, fg = colors.base, style = { "bold" } },

          TelescopeResultsNormal = { bg = colors.mantle },
          TelescopeResultsBorder = { fg = colors.mantle, bg = colors.mantle },

          TelescopePreviewNormal = { bg = colors.base },
          TelescopePreviewBorder = { fg = colors.red, bg = colors.base },

          DiagnosticVirtualTextHint = { fg = colors.overlay0, bg = colors.none },
          DiagnosticVirtualTextInfo = { fg = colors.overlay0, bg = colors.none },
          DiagnosticVirtualTextWarn = { bg = colors.none },
          DiagnosticVirtualTextError = { bg = colors.none },

          LspDiagnosticsUnderlineHint = { fg = colors.overlay0, bg = colors.none },
          LspDiagnosticsUnderlineInformation = { fg = colors.overlay0, bg = colors.none },

          DiagnosticUnderlineHint = { fg = colors.overlay0 },
          DiagnosticUnderlineWarn = { fg = colors.yellow },
          DiagnosticUnderlineError = { fg = colors.red },
          LspDiagnosticsUnderlineError = { fg = colors.red },
          LspDiagnosticsUnderlineWarning = { fg = colors.yellow },

          LspSignatureActiveParameter = { fg = colors.teal },

          SpellBad = { fg = colors.red, style = {} },
          SpellCap = { fg = colors.yellow, style = {} },
          SpellRare = { fg = colors.green, style = {} },
          SpellLocal = { fg = colors.teal, style = {} },

          CmpNormal = { fg = colors.text, bg = colors.mantle },
          CmpDoc = { bg = colors.crust },
          CmdDocBorder = { bg = colors.crust },

          CmpItemKind = { fg = colors.blue },
          CmpItemMenu = { fg = colors.surface1 },
          CmpItemAbbrMatch = { fg = colors.blue, style = { "bold" } },
          CmpItemAbbrMatchFuzzy = { fg = colors.blue, style = { "bold" } },

          CmpItemKindSnippet = { fg = colors.base, bg = colors.mauve },
          CmpItemKindKeyword = { fg = colors.base, bg = colors.red },
          CmpItemKindText = { fg = colors.base, bg = colors.teal },
          CmpItemKindMethod = { fg = colors.base, bg = colors.blue },
          CmpItemKindConstructor = { fg = colors.base, bg = colors.blue },
          CmpItemKindFunction = { fg = colors.base, bg = colors.blue },
          CmpItemKindFolder = { fg = colors.base, bg = colors.blue },
          CmpItemKindModule = { fg = colors.base, bg = colors.blue },
          CmpItemKindConstant = { fg = colors.base, bg = colors.peach },
          CmpItemKindField = { fg = colors.base, bg = colors.green },
          CmpItemKindProperty = { fg = colors.base, bg = colors.green },
          CmpItemKindEnum = { fg = colors.base, bg = colors.green },
          CmpItemKindUnit = { fg = colors.base, bg = colors.green },
          CmpItemKindClass = { fg = colors.base, bg = colors.yellow },
          CmpItemKindVariable = { fg = colors.base, bg = colors.flamingo },
          CmpItemKindFile = { fg = colors.base, bg = colors.blue },
          CmpItemKindInterface = { fg = colors.base, bg = colors.yellow },
          CmpItemKindColor = { fg = colors.base, bg = colors.red },
          CmpItemKindReference = { fg = colors.base, bg = colors.red },
          CmpItemKindEnumMember = { fg = colors.base, bg = colors.red },
          CmpItemKindStruct = { fg = colors.base, bg = colors.blue },
          CmpItemKindValue = { fg = colors.base, bg = colors.peach },
          CmpItemKindEvent = { fg = colors.base, bg = colors.blue },
          CmpItemKindOperator = { fg = colors.base, bg = colors.blue },
          CmpItemKindTypeParameter = { fg = colors.base, bg = colors.blue },
          CmpItemKindCopilot = { fg = colors.base, bg = colors.teal },
        }
      end,
    },
    config = function(_, opts)
      -- local colors = require "core.colors"
      -- opts.color_overrides = { all = colors.catbox_material }
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme "catppuccin"
    end,
  },
}
