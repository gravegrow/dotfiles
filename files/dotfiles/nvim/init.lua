local preset = "user"

if vim.g.vscode then
  preset = "unity"
end

require(preset)
