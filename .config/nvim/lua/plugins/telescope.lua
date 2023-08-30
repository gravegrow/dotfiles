local M = {}

M.window = {
  results_title = false,
  preview_title = false,
  layout_strategy = "vertical",
  layout_config = {
    preview_height = 0.25,
    width = 85,
  },
}

M.opts = {
  defaults = {
    prompt_prefix = "  ",
    selection_caret = " ",
    file_ignore_patterns = {
      -- ".pyc",
      -- ".meta",
      -- ".sln",
      -- ".csproj",
      -- "DS_Store",
      -- ".booproj",
      -- ".pidb",
      -- ".suo",
      -- ".user",
      -- ".userprefs",
      -- ".unityproj",
      -- ".dll",
      -- ".exe",
      -- ".pdf",
      -- ".mid",
      -- ".midi",
      -- ".wav",
      -- ".gif",
      -- ".ico",
      -- ".jpg",
      -- ".jpeg",
      -- ".png",
      -- ".psd",
      -- ".tga",
      -- ".tif",
      -- ".tiff",
      -- ".3ds",
      -- ".3DS",
      -- ".fbx",
      -- ".FBX",
      -- ".lxo",
      -- ".LXO",
      -- ".ma",
      -- ".MA",
      -- ".obj",
      -- ".OBJ",
      -- ".asset",
      -- ".cubemap",
      -- ".flare",
      -- ".mat",
      -- ".meta",
      -- ".prefab",
      -- ".unity",
    },
  },
  pickers = {
    -- diagnostics = { theme = "ivy" },
    diagnostics = M.window,
    find_files = M.window,
    git_files = M.window,
    oldfiles = M.window,
    live_grep = M.window,
    highlights = M.window,
  },
}

M.config = function(_, opts)
  require("telescope").setup(opts)
  local builtin = require "telescope.builtin"

  vim.keymap.set("n", "<leader>ff", builtin.find_files)
  vim.keymap.set("n", "<leader>fg", builtin.git_files)
  vim.keymap.set("n", "<leader>fo", builtin.oldfiles)
  vim.keymap.set("n", "<leader>fd", builtin.diagnostics)
  vim.keymap.set("n", "<leader>lg", builtin.live_grep)
  vim.keymap.set("n", "<leader>th", builtin.highlights)
  vim.keymap.set("n", "<leader>fh", function()
    builtin.find_files { hidden = true }
  end)
end

M.keys = {
  { "<leader>ff" },
  { "<leader>fg" },
  { "<leader>fo" },
  { "<leader>fd" },
  { "<leader>lg" },
  { "<leader>th" },
  { "<leader>fh" },
}

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = M.keys,
    opts = M.opts,
    config = M.config,
  },
}
