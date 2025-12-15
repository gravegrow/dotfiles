return {
  name = "CompileAll",
  builder = function()
    local executable = vim.fn.expand("%:p:t:r")

    local find_files = function(filetype)
      local command = string.format("find src/ -type f -name '*.%s'", filetype)
      local result = vim.fn.system(command)
      return vim.split(result, "\n")
    end

    local configs = {
      cpp = {
        cmd = "clang++",
        std = "-std=c++20",
        files = find_files("cpp"),
      },
      c = {
        cmd = "clang",
        std = "-std=c11",
        files = find_files("c"),
      },
    }

    local config = configs[vim.bo.filetype]
    local args = { config.std, "-glldb", "-fstandalone-debug", "-o", executable }

    for _, cfile in pairs(config.files) do
      table.insert(args, 1, cfile)
    end

    return {
      cmd = { config.cmd },
      args = args,
      components = { { "on_complete_notify", statuses = { "FAILURE" } }, "default" },
    }
  end,
  condition = {
    filetype = { "cpp", "c" },
  },
}
