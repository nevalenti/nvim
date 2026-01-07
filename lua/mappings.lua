local map = vim.keymap.set

map("n", "<Space>", "<Nop>", { silent = true, desc = "Disable space" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader><CR>", "<cmd>cd %:h<CR>", { desc = "Set CWD to current file" })

map("n", "<leader>o", "<cmd>update<CR><cmd>source<CR>", { desc = "Save and source file" })
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit window" })
map("n", "<leader>Q", "<cmd>quit!<CR>", { desc = "Force quit window" })

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move to right window" })

map("n", "n", "nzzzv", { desc = "Next search result and center" })
map("n", "N", "Nzzzv", { desc = "Previous search result and center" })
map("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
map("v", "J", "<cmd>m '>+1<CR>gv=gv", { desc = "Move selected line down" })
map("v", "K", "<cmd>m '<-2<CR>gv=gv", { desc = "Move selected line up" })

map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

map("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
map("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })

map("n", "<leader>j", "<cmd>lnext<CR>zz", { desc = "Next location list item" })
map("n", "<leader>k", "<cmd>lprev<CR>zz", { desc = "Previous location list item" })

map(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Search and replace word under cursor" }
)

map("n", "<leader>fm", vim.lsp.buf.format, { desc = "Format buffer" })

map("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })
map("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment" })
