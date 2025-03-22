return {
  name = "Compile",
  builder = function()
    local file = vim.fn.expand("%:p")
    local executable = vim.fn.expand("%:p:t:r")
    return {
      cmd = { "clang" },
      args = { "-std=c11", "-glldb", "-fstandalone-debug", file, "-o", executable },
      components = { { "on_complete_notify", statuses = { "FAILURE" } }, "default" },
    }
  end,
  condition = {
    filetype = { "c" },
  },
}
