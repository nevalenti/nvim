return {
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" },
    csharp = { "csharpier" },
    python = { "ruff" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}
