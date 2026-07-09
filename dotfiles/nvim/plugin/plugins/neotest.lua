vim.pack.add({
    "https://github.com/nvim-neotest/neotest",
    "https://github.com/nvim-neotest/nvim-nio",
    "https://github.com/nsidorenco/neotest-vstest",
})

local neotest = require("neotest")
neotest.setup({
    adapters = {
        require("neotest-vstest"),
    },
    summary = {
        open = "botright split | resize " .. math.floor(vim.o.lines * 0.3),
    },
    highlights = {
        adapter_name = "Search",
        border = "NeotestBorder",
        dir = "ui_fg_color4",
        expand_marker = "Whitespace",
        failed = "ui_fg_color1",
        file = "ui_fg_foreground",
        focused = "NeotestFocused",
        indent = "Whitespace",
        marked = "NeotestMarked",
        namespace = "ui_fg_color6",
        passed = "ui_fg_color10",
        running = "ui_fg_color11",
        select_win = "NeotestWinSelect",
        skipped = "ui_fg_color14",
        target = "NeotestTarget",
        test = "NeotestTest",
        unknown = "NeotestUnknown",
        watching = "NeotestWatching",
    },
    icons = {
        running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
    },
})

local keymap = vim.keymap.set

keymap("n", "<leader>nt", function()
    neotest.summary.toggle({ enter = true })
end, { desc = "Neotest Toggle Summary" })

vim.keymap.set("n", "<leader>nR", function()
    neotest.run.run(vim.loop.cwd())
end, { desc = "Run All Tests in Project" })

vim.keymap.set("n", "<leader>nr", function()
    neotest.run.run(vim.api.nvim_buf_get_name(0))
end, { desc = "Run Current File Tests" })

vim.keymap.set("n", "<leader>no", function()
    neotest.output.open()
end, { desc = "Output Window" })
