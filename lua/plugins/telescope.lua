require("telescope").setup {}
require('telescope').load_extension 'remote-sshfs'

local map = vim.keymap.set
local builtin = require('telescope.builtin')

map('n', '<leader>ff', builtin.find_files, { desc = "Telescope: Find files" })
map('n', '<leader>fg', builtin.live_grep, { desc = "Telescope: Live grep" })
map('n', '<leader>fb', builtin.buffers, { desc = "Telescope Buffers" })
map('n', '<leader>fr', builtin.resume, { desc = "Telescope: Resume" })
