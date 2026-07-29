vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_show_help = 0
vim.g.db_ui_win_position = "left"
vim.g.db_ui_winwidth = 40

local map = vim.keymap.set

map("n", "<leader>du", "<cmd>DBUIToggle<CR>", { desc = "DB: Toggle UI" })
map("n", "<leader>df", "<cmd>DBUIFindBuffer<CR>", { desc = "DB: Find buffer" })
map("n", "<leader>dr", "<cmd>DBUIRenameBuffer<CR>", { desc = "DB: Rename buffer" })
map("n", "<leader>dq", "<cmd>DBUILastQueryInfo<CR>", { desc = "DB: Last query info" })
