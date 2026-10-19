require("satellite").setup {
  current_only = true,
  winblend = 0,
  handlers = {
    search = { enable = true },
    diagnostic = { enable = true },
    gitsigns = { enable = true },
    marks = { enable = false },
    cursor = { enable = true },
  },
}
