local map = vim.keymap.set

map("n", "<leader>/", "gcc", { remap = true, desc = "Toggle line comment" })
map("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment for selection" })
