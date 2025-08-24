local map = vim.keymap.set

map("n", "<Space>", "<Nop>", { silent = true, desc = "Disable space" })
map("n", ";", ":", { desc = "Command mode" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("n", "<Esc>", "<CMD>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader><CR>", ":cd %:h<CR>", { desc = "Set CWD to current file" })

map('n', '<leader>o', ':update<CR>:source<CR>', { desc = "Save and source" })
map('n', '<leader>w', ':write<CR>', { desc = "Save file" })
map('n', '<leader>q', ':quit<CR>', { desc = "Quit" })

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move to window below" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move to window above" })

map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
map("n", "n", "nzzzv", { desc = "Center search result" })
map("n", "N", "Nzzzv", { desc = "Center previous search result" })
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

map("n", "<leader>fm", vim.lsp.buf.format, { desc = "Format buffer" })

