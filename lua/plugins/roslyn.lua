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

-- Roslyn sends member-access dots as operator tokens, which would paint them
-- over Treesitter's punctuation; keep them with the other separators.
vim.api.nvim_create_autocmd("LspTokenUpdate", {
  group = vim.api.nvim_create_augroup("RoslynDots", { clear = true }),
  callback = function(args)
    local token = args.data.token
    if token.type ~= "operator" then
      return
    end
    local line = vim.api.nvim_buf_get_lines(args.buf, token.line, token.line + 1, false)[1] or ""
    local text = line:sub(token.start_col + 1, token.end_col)
    local next_char = line:sub(token.end_col + 1, token.end_col + 1)
    if text == "." or text == "?." or (text == "?" and next_char == ".") then
      vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id, "@punctuation.delimiter")
    end
  end,
})
