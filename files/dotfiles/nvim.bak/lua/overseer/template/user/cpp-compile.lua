return {
  name = "Compile",
  builder = function()
    local file = vim.fn.expand("%:p")
    local executable = vim.fn.expand("%:p:t:r")
    local configs = {
      cpp = {
        cmd = "clang++",
        std = "-std=c++20",
      },
      c = {
        cmd = "clang",
        std = "-std=c11",
      },
    }

    local config = configs[vim.bo.filetype]

    return {
      cmd = { config.cmd },
      args = { file, config.std, "-glldb", "-fstandalone-debug", "-o", executable },
      components = { { "on_complete_notify", statuses = { "FAILURE" } }, "default" },
    }
  end,
  condition = {
    filetype = { "cpp", "c" },
  },
}
