require("conform").setup {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports", "gofmt" },
    python = { "ruff_format" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    cs = { "csharpier" },
  },
  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = true,
  },
  formatters = {
    csharpier = {
      -- Use the project's pinned dotnet-tools.json version instead of the
      -- Mason-installed csharpier, so editor output matches `csharpier check` in CI.
      command = "dotnet",
      args = { "csharpier", "format", "--stdin-path", "$FILENAME" },
    },
  },
}

vim.keymap.set({ "n", "v" }, "<leader>fm", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "Format buffer" })
