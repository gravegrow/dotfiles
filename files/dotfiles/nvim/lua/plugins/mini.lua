return {
    "nvim-mini/mini.nvim",
    config = function()
        require("mini.icons").setup()
        require("mini.icons").mock_nvim_web_devicons()

        require("mini.align").setup()
        require("mini.splitjoin").setup()
        require("mini.surround").setup()

        require("mini.notify").setup({
            content = {
                format = function(notif)
                    return notif.msg
                end,
            },
            window = {
                max_width_share = 0.5,
                winblend = 0,
                config = function()
                    local has_statusline = vim.o.laststatus > 0
                    local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
                    return {
                        anchor = "SE",
                        title = "",
                        border = "none",
                        col = vim.o.columns,
                        row = vim.o.lines - pad,
                    }
                end,
            },
        })
    end,
}
