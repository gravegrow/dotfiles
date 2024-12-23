local preset = "user"

if vim.g.vscode then
  preset = "code"
end

require(preset)
