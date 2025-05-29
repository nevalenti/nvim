return {
  formatters_by_ft = {
    lua = { "stylua" },
    html = { "prettier" },
    css = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    python = { "ruff" },
    csharp = { "csharpier" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}
