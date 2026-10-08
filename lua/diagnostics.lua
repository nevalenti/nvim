vim.diagnostic.config {
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "\u{F057}",
      [vim.diagnostic.severity.WARN] = "\u{F071}",
      [vim.diagnostic.severity.HINT] = "\u{F0EB}",
      [vim.diagnostic.severity.INFO] = "\u{F05A}",
    },
    active = true,
    priority = 20,
  },
  update_in_insert = false,
  underline = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    header = "",
    prefix = "",
  },
}
