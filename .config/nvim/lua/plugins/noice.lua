return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        lsp = {
            signature = { enabled = true, view = nil },
            progress = { enabled = true, view = 'mini' },
        },
        notify = { enabled = false },
        messages = { enabled = false },
        cmdline = { view = "cmdline" },
    },
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },

}
