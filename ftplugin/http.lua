local kulala = require "kulala"

vim.keymap.set("n", "<leader>Rr", kulala.run, { buffer = true, desc = "HTTP: Run request under cursor" })
vim.keymap.set("n", "<leader>Rl", kulala.replay, { buffer = true, desc = "HTTP: Replay last request" })
vim.keymap.set("n", "<leader>Ro", kulala.open, { buffer = true, desc = "HTTP: Open response" })
vim.keymap.set("n", "<leader>Re", kulala.set_selected_env, { buffer = true, desc = "HTTP: Select environment" })
