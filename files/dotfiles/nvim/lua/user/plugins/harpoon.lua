return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = { settings = { save_on_toggle = true } },

  config = function(_, opts)
    local harpoon = require("harpoon")

    harpoon:setup(opts)

    local toggle_opts = { title = " Harpoon ", title_pos = "center" }

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()

      local default = vim.notify
      local status, fidget = pcall(require, "fidget")
      if status then
        vim.notify = fidget.notify
      end

      local name = vim.fn.expand("%:t")
      vim.notify('"' .. name .. '" added to Harpoon list.')
      vim.notify = default
    end, { desc = "Harpoon [A]dd to list" })

    vim.keymap.set("n", "<leader>h", function()
      harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts)
    end, { desc = "[H]arpoon toggle" })

    for i, v in ipairs({ "h", "j", "k", "l" }) do
      vim.keymap.set("n", ("<C-%s>"):format(v), function()
        harpoon:list():select(i)
      end)
    end

    vim.cmd("autocmd Filetype harpoon setlocal cursorline")
  end,
}
