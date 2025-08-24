require('oil').setup {
  columns = {
    "icon",
    "permissions",
    "size",
    "mtime",
  },
  view_options = {
    show_hidden = true
  }
}

local map = vim.keymap.set

map("n", "<leader>e", ":Oil<CR>", { desc = "Toggle Oil file explorer" })

