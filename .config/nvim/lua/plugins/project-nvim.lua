return {
  "ahmedkhalf/project.nvim",
  event = "UIEnter",
  opts = {
    ignore_lsp = { "null-ls" },
    show_hidden = true,
    patterns = { ".root" },
  },
  config = function(_, opts)
    require("project_nvim").setup(opts)
    require("telescope").load_extension "projects"

    local theme = function()
      local height = 5 + #require("project_nvim").get_recent_projects()
      return {
        results_title = false,
        preview_title = false,
        prompt_title = "Projects",
        sorting_strategy = "descending",
        layout_config = {
          height = height,
          prompt_position = "bottom",
          width = 80,
        },
      }
    end

    vim.keymap.set({ "n", "v" }, "<leader>p", function()
      require("telescope").extensions.projects.projects(theme())
    end)
  end,
}
