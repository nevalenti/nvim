require("which-key").setup {
  preset = "modern",
  delay = 300,
  win = {
    border = "rounded",
    padding = { 1, 2 },
    title_pos = "left",
    wo = { winblend = 0 },
  },
  layout = { spacing = 5 },
  icons = {
    mappings = false,
    rules = false,
  },
}

require("which-key").add {
  { "<leader>f", group = "Find / Search" },
  { "<leader>g", group = "Git" },
  { "<leader>l", group = "LSP" },
  { "<leader>t", group = "Tests" },
  { "<leader>d", group = "Diagnostics / Debug" },
  { "<leader>x", group = "Backend" },
  { "<leader>a", group = "AI assistant" },
}
