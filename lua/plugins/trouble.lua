require("trouble").setup {}

local map = vim.keymap.set

map("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Toggle Trouble diagnostics" })
map("n", "]e", function()
  require("trouble").next { skip_groups = true, jump = true }
end, { desc = "Next Trouble item" })
map("n", "[e", function()
  require("trouble").previous { skip_groups = true, jump = true }
end, { desc = "Previous Trouble item" })
