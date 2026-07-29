require("toggleterm").setup {
  size = 15,
  open_mapping = [[<C-\>]],
  direction = "float",
  shade_terminals = false,
  float_opts = {
    border = "rounded",
    winblend = 0,
  },
}

local map = vim.keymap.set
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Move to left window" })
map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Move to bottom window" })
map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Move to top window" })
map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Move to right window" })
