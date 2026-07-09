vim.pack.add({ "https://github.com/wnkz/monoglow.nvim" })
require("monoglow").setup({
    on_colors = function(colors)
        colors.glow = "#d27e99"
    end,
    on_highlights = function(hl, colors)
        hl.String = { fg = colors.lack }
    end,
})

vim.cmd.colorscheme("monoglow-lack")
