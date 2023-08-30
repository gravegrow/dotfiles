return {
  "tamago324/nlsp-settings.nvim",
  event = "LspAttach",
  config = function()
    require("nlspsettings").setup {
      config_home = vim.fn.stdpath "config" .. "/lsp-settings",
      local_settings_dir = "",
      local_settings_root_markers_fallback = { ".git" },
      append_default_schemas = true,
      loader = "json",
    }
  end,
}
