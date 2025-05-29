local oil = require('oil')

oil.setup {
  default_file_explorer = true,
  columns = {
    "icon",
    "permissions",
    "size",
    "mtime",
  },
  view_options = {
    show_hidden = true
  },
  win_options = {
    signcolumn = "yes:2",
  },
  float = {
    open_by_default = true,
    padding = 0,
    max_width = 0.9,
    max_height = 0.8,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
  },
}
require("oil-git-status").setup {}

local map = vim.keymap.set

map("n", "<leader>e", function() oil.toggle_float() end, { desc = "Toggle Oil file explorer" })
