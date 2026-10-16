require("trouble").setup {
  use_diagnostic_signs = true,
  modes = {
    symbols = {
      focus = false,
      follow = true,
      auto_preview = false,
      win = { position = "right", size = 35 },
    },
  },
}

local map = vim.keymap.set

map("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Trouble: Toggle diagnostics" })
map("n", "<leader>tQ", "<cmd>Trouble qflist toggle<CR>", { desc = "Trouble: Toggle quickfix list" })
map("n", "<leader>ls", "<cmd>Trouble symbols toggle<CR>", { desc = "Trouble: Toggle symbols outline" })
map("n", "<leader>lci", "<cmd>Trouble lsp_incoming_calls toggle focus=true<CR>", { desc = "Trouble: Incoming calls" })
map("n", "<leader>lco", "<cmd>Trouble lsp_outgoing_calls toggle focus=true<CR>", { desc = "Trouble: Outgoing calls" })
map("n", "]T", function()
  require("trouble").next { skip_groups = true, jump = true }
end, { desc = "Trouble: Next item" })
map("n", "[T", function()
  require("trouble").previous { skip_groups = true, jump = true }
end, { desc = "Trouble: Previous item" })
