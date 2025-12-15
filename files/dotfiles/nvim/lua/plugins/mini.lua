return {
    "nvim-mini/mini.nvim",
    config = function()
        require("mini.icons").setup()
        require("mini.icons").mock_nvim_web_devicons()

        require("mini.pick").setup()

        require("mini.align").setup()
        require("mini.splitjoin").setup()
        require("mini.surround").setup()
    end,
}
