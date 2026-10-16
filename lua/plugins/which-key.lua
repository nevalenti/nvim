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
  { "<leader>fg", group = "Git pickers" },
  { "<leader>fl", group = "LSP pickers" },
  { "<leader>h", group = "Harpoon" },
  { "<leader>j", group = "Java" },
  { "<leader>y", group = "Yank path" },
  { "<leader>l", group = "LSP" },
  { "<leader>lc", group = "Call hierarchy" },
  { "<leader>p", group = "Project" },
  { "<leader>r", group = "Refactor" },
  { "<leader>t", group = "Tests / Toggles" },
  { "<leader>s", group = "Session / Substitute" },
  { "<leader>c", group = "Code / Quickfix" },
  { "<leader>d", group = "Diagnostics / Debug" },
  { "<leader>x", group = "Backend" },
  { "<leader>a", group = "AI assistant" },
}
