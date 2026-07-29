require("persistence").setup {}

local map = vim.keymap.set

map("n", "<leader>ss", function()
  require("persistence").load()
end, { desc = "Restore session for this directory" })

map("n", "<leader>sl", function()
  require("persistence").load { last = true }
end, { desc = "Restore last session" })

map("n", "<leader>sd", function()
  require("persistence").stop()
end, { desc = "Stop persistence (don't save session on exit)" })
