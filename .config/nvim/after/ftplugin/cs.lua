vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4

--[[ local ok, nvimtree = pcall(require, "nvim-tree")
if ok then
  local opts = require("plugins.nvim-tree").opts
  opts.filters.custom = {
    "*.meta",
    "*.asmdef",
    ".csproj",
    "*.sln",
  }

  nvimtree.setup(opts)
end

local ok, telescope = pcall(require, "module")
if ok then
  local opts = require("plugins.telescope").opts
  opts.defaults.file_ignore_patterns = vim.tbl_deep_extend("keep", opts.defaults.file_ignore_patterns, {
    ".asmdef",
    "*.meta",
    "build/",
    "Build/",
    "Library/",
    "library/",
    "obj/",
    "Obj/",
    "ProjectSettings/",
    "UserSettings/",
    "temp/",
    "Temp/",
    "Packages/",
    "packages/",
    "Logs/",
    "logs/",
  })

  telescope.setup(opts)
end ]]
