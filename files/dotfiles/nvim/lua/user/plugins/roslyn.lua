return {
  "seblj/roslyn.nvim",
  keys = {
    { "<leader>rr", "<cmd>Roslyn restart<cr>", mode = "n" },
  },
  ft = "cs",
  config = function()
    require("roslyn").setup()
    vim.lsp.config("roslyn", {
      settings = {
        ["csharp|completion"] = {
          dotnet_show_completion_items_from_unimported_namespaces = true,
        },
        ["csharp|inlay_hints"] = {
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          csharp_enable_inlay_hints_for_implicit_variable_types = true,
          csharp_enable_inlay_hints_for_lambda_parameter_types = true,
          csharp_enable_inlay_hints_for_types = true,
          dotnet_enable_inlay_hints_for_indexer_parameters = true,
          dotnet_enable_inlay_hints_for_literal_parameters = true,
          dotnet_enable_inlay_hints_for_object_creation_parameters = true,
          dotnet_enable_inlay_hints_for_other_parameters = true,
          dotnet_enable_inlay_hints_for_parameters = true,
          dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
          dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
          dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
        },
      },
    })
    local ok, fidget = pcall(require, "fidget")
    if ok then
      vim.notify = fidget.notify
    end
  end,
}
