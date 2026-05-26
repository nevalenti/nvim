local mark = require "harpoon.mark"
local ui = require "harpoon.ui"

local map = vim.keymap.set

map("n", "<leader>ha", mark.add_file, { desc = "Harpoon: Add file" })
map("n", "<leader>hh", ui.toggle_quick_menu, { desc = "Harpoon: Menu" })
map("n", "<leader>1", function() ui.nav_file(1) end, { desc = "Harpoon: File 1" })
map("n", "<leader>2", function() ui.nav_file(2) end, { desc = "Harpoon: File 2" })
map("n", "<leader>3", function() ui.nav_file(3) end, { desc = "Harpoon: File 3" })
map("n", "<leader>4", function() ui.nav_file(4) end, { desc = "Harpoon: File 4" })
