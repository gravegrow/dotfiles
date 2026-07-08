require("vim._core.ui2").enable({})

vim.pack.add({ "https://github.com/wnkz/monoglow.nvim" })
require("monoglow").setup({
    on_colors = function(colors)
        colors.glow = "#d27e99"
    end,
    on_highlights = function(hl, colors)
        hl.String = { fg = colors.lack }
        hl.NormalFloat = { link = "Normal" }
        hl.FloatBorder = { fg = colors.gray4 }
        hl.StatusLine = { bg = "#0a0a0a" }
        hl.StatusLineNC = { bg = "#0a0a0a" }
        hl.PmenuSel = { bg = colors.gray3 }
        hl.GitSignsAddLn = { link = "Added" }
        hl.GitSignsAddPreview = { link = "Added" }
        hl.GitSignsDeleteLn = { link = "Removed" }
        hl.GitSignsDeletePreview = { link = "Removed" }
    end,
})

vim.cmd.colorscheme("monoglow-lack")
