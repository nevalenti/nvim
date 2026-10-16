require("persistence").setup {}

local map = vim.keymap.set

map("n", "<leader>ss", function()
  require("persistence").load()
end, { desc = "Session: Restore for this directory" })

map("n", "<leader>sl", function()
  require("persistence").load { last = true }
end, { desc = "Session: Restore last session" })

map("n", "<leader>sd", function()
  require("persistence").stop()
end, { desc = "Session: Don't save on exit" })
