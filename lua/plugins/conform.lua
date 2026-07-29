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
    java = { "google-java-format" },
    php = { "php_cs_fixer" },
  },
  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = true,
  },
  formatters = {
    csharpier = {
      command = "dotnet",
      args = { "csharpier", "format", "--stdin-path", "$FILENAME" },
    },
  },
}

vim.keymap.set({ "n", "v" }, "<leader>fm", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "Format buffer" })
