return {
  "mini.nvim",
  enabled = true,
  opts = {
    files = {
      mappings = {
        close = "<Esc>",
        go_in_plus = "<CR>",
      },
      windows = {
        max_number = 1,
        width_focus = 32,
        width_preview = 20,
      },
    },
  },
  keys = {
    {
      "<c-e>",
      function()
        local minifiles = require("mini.files")
        function string:endswith(ending)
          ---@diagnostic disable-next-line: param-type-mismatch
          return ending == "" or self:sub(-#ending) == ending
        end

        local height = vim.api.nvim_win_get_height(0) - 2
        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniFilesWindowUpdate",
          group = vim.api.nvim_create_augroup("MiniFilesWinUpdGrp", { clear = true }),
          callback = function(args)
            local win_id = args.data.win_id
            local config = vim.api.nvim_win_get_config(win_id)
            config.height = height
            config.title[1][1] = ""
            vim.api.nvim_win_set_config(win_id, config)
          end,
        })

        if not minifiles.close() then
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
      end,
    },
  },
}
