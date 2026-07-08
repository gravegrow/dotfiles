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
        open = "botright split | resize " .. math.floor(vim.o.lines * 0.25),
    },
})

local keymap = vim.keymap.set

keymap("n", "<leader>nt", neotest.summary.toggle, { desc = "Neotest Toggle Summary" })
keymap("n", "<leader>nr", neotest.summary.toggle, { desc = "Neotest Toggle Summary" })

vim.keymap.set("n", "<leader>nR", function()
    require("neotest").run.run(vim.loop.cwd())
end, { desc = "Run All Tests in Project" })

vim.keymap.set("n", "<leader>nr", function()
    require("neotest").run.run(vim.api.nvim_buf_get_name(0))
end, { desc = "Run Current File Tests" })
