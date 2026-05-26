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
}

vim.keymap.set({ "n", "v" }, "<leader>fm", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "Format buffer" })
