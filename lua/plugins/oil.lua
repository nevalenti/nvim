local oil = require "oil"

oil.setup {
  default_file_explorer = false,
  columns = {
    "icon",
    "permissions",
    "size",
    "mtime",
  },
  view_options = {
    show_hidden = true,
  },
  win_options = {
    signcolumn = "yes:2",
  },
  float = {
    open_by_default = true,
    padding = 0,
    max_width = 0.8,
    max_height = 0.8,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
  },
  keymaps = {
    ["<leader>e"] = { "actions.parent", mode = "n" },
  },
}
require("oil-git-status").setup {}

local map = vim.keymap.set

map("n", "<leader>e", function()
  if not oil.get_current_dir() then
    oil.open_float()
  end
end, { desc = "Toggle Oil file explorer" })
