vim.diagnostic.config {
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "\u{F057}", -- times-circle
      [vim.diagnostic.severity.WARN] = "\u{F071}", -- exclamation-triangle
      [vim.diagnostic.severity.HINT] = "\u{F0EB}", -- lightbulb
      [vim.diagnostic.severity.INFO] = "\u{F05A}", -- info-circle
    },
    active = true,
    priority = 20,
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    header = "",
    prefix = "",
  },
}
