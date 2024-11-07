return {
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  config = function()
    require("mini.ai").setup()
    require("mini.align").setup()
    -- require("mini.pairs").setup()
    require("mini.splitjoin").setup()
    require("mini.surround").setup()

    require("mini.icons").setup({
      extension = { cpp = { glyph = "" }, h = { glyph = "󰰀" } },
    })
    require("mini.icons").mock_nvim_web_devicons()

    require("mini.hipatterns").setup({
      highlighters = {
        fix = { pattern = "%f[%w]()FIX()%f[%W]", group = "MiniHipatternsFixme" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
      },
    })

    require("mini.files").setup({
      mappings = {
        close = "<Esc>",
        go_in_plus = "<CR>",
      },
      windows = {
        max_number = 3,
        width_focus = 30,
        width_preview = 20,
      },
    })

    vim.keymap.set("n", "<c-e>", function()
      local minifiles = require "mini.files"
      if not minifiles.close() then
        -- minifiles.open(vim.api.nvim_buf_get_name(0), false)
        -- minifiles.reveal_cwd()

        minifiles.open()
        minifiles.refresh({
          content = {
            filter = function(fs_entry)
              return not vim.startswith(fs_entry.name, "__py")
            end,
          },
        })
      end
    end, { desc = "Mini File [E]xplorer" })
  end,
}
