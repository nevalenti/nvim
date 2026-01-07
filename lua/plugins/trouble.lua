require("trouble").setup {
  use_diagnostic_signs = true,
}

local map = vim.keymap.set

map("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Toggle Trouble diagnostics" })
map("n", "[t", function()
  require("trouble").next { skip_groups = true, jump = true }
end)
map("n", "]t", function()
  require("trouble").previous { skip_groups = true, jump = true }
end)
