require("diffview").setup {}

local map = vim.keymap.set

map("n", "<leader>gv", "<cmd>DiffviewOpen<CR>", { desc = "Diffview: Open working tree changes" })

map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "Diffview: Current file history" })
map("v", "<leader>gh", "<cmd>DiffviewFileHistory<CR>", { desc = "Diffview: History of selected lines" })
