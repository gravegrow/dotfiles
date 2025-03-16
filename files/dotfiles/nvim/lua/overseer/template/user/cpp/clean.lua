return {
  name = "Clean",
  builder = function()
    local executable = vim.fn.expand("%:p:t:r")
    return {
      cmd = { "rm" },
      args = { executable },
      -- components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = { "cpp" },
  },
}
