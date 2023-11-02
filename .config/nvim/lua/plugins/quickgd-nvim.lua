return {
  "QuickGD/quickgd.nvim",
  ft = { "gdshader", "gdshaderinc" },
  cmd = { "GodotRun", "GodotRunLast", "GodotStart" },
  -- Use opts if passing in settings else use config
  init = function()
    vim.filetype.add {
      extension = {
        gdshaderinc = "gdshaderinc",
      },
    }
  end,
  opts = {
    godot_path = "/media/storage/software/godot/Godot_v4.1.1-stable_linux.x86_64",
  }, -- remove config and use this if changing settings.
}
