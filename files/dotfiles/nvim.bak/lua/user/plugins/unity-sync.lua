return {
  "apyra/nvim-unity-sync",
  dependencies = {
    "nvim-tree/nvim-tree.lua",
  },
  ft = "cs",
  config = function()
    require("unity.plugin").setup()
  end,
}
