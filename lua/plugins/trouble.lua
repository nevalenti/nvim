local map = vim.keymap.set

map("n", "<leader>tt", "<CMD>Trouble diagnostics toggle<CR>", { desc = "Toggle Trouble" })
map("n", "[t", function()
  require("trouble").next({ skip_groups = true, jump = true });
end)
map("n", "]t", function()
  require("trouble").previous({ skip_groups = true, jump = true });
end)
