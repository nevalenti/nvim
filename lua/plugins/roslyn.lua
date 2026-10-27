require("roslyn").setup {}

vim.lsp.config("roslyn", {
  settings = {
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = false,
      csharp_enable_inlay_hints_for_implicit_variable_types = false,
      csharp_enable_inlay_hints_for_lambda_parameter_types = false,
      csharp_enable_inlay_hints_for_types = false,
      dotnet_enable_inlay_hints_for_parameters = true,
      dotnet_enable_inlay_hints_for_literal_parameters = true,
      dotnet_enable_inlay_hints_for_indexer_parameters = true,
    },
    ["csharp|code_lens"] = {
      dotnet_enable_references_code_lens = true,
    },
  },
})
