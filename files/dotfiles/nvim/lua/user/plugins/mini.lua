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
      extension = {
        cpp = { glyph = "" },
        h = { glyph = "󰰀" },
      },
    })
    require("mini.icons").mock_nvim_web_devicons()

    require("mini.hipatterns").setup({
      highlighters = {
        fix = { pattern = "%f[%w]()FIX()%f[%W]", group = "MiniHipatternsFixme" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
        info = { pattern = "%f[%w]()INFO()%f[%W]", group = "MiniHipatternsNote" },
      },
    })

    require("mini.files").setup({
      mappings = {
        close = "<Esc>",
        go_in_plus = "<CR>",
      },
      windows = {
        max_number = 1,
        width_focus = 30,
        width_preview = 20,
      },
    })

    function string:endswith(ending)
      ---@diagnostic disable-next-line: param-type-mismatch
      return ending == "" or self:sub(-#ending) == ending
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesWindowUpdate",
      callback = function(args)
        local win_id = args.data.win_id

        local config = vim.api.nvim_win_get_config(win_id)
        config.height = 100
        vim.api.nvim_win_set_config(win_id, config)
      end,
    })

    vim.keymap.set("n", "<c-e>", function()
      local minifiles = require("mini.files")
      if not minifiles.close() then
        -- minifiles.open(vim.api.nvim_buf_get_name(0), false)
        -- minifiles.reveal_cwd()

        minifiles.open()
        minifiles.refresh({
          content = {
            filter = function(entry)
              return entry.name ~= ".DS_Store"
                and entry.name ~= ".git"
                and entry.name ~= ".direnv"
                and not entry.name:endswith("meta")
            end,
            sort = function(entries)
              -- technically can filter entries here too, and checking gitignore for _every entry individually_
              -- like I would have to in `content.filter` above is too slow. Here we can give it _all_ the entries
              -- at once, which is much more performant.
              local all_paths = table.concat(
                vim.tbl_map(function(entry)
                  return entry.path
                end, entries),
                "\n"
              )
              local output_lines = {}
              local job_id = vim.fn.jobstart({ "git", "check-ignore", "--stdin" }, {
                stdout_buffered = true,
                on_stdout = function(_, data)
                  output_lines = data
                end,
              })
              -- command failed to run
              if job_id < 1 then
                return entries
              end
              -- send paths via STDIN
              vim.fn.chansend(job_id, all_paths)
              vim.fn.chanclose(job_id, "stdin")
              vim.fn.jobwait({ job_id })
              return require("mini.files").default_sort(vim.tbl_filter(function(entry)
                return not vim.tbl_contains(output_lines, entry.path)
              end, entries))
            end,
          },
        })
      end
    end, { desc = "Mini File [E]xplorer" })
  end,
}
