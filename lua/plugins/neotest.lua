local map = vim.keymap.set

require("neotest").setup {
  adapters = {
    require "neotest-vitest",
    require("neotest-jest") { jestCommand = "npx jest --" },
  },
  output = { open_on_run = true },
}

map("n", "<leader>tr", function() require("neotest").run.run() end, { desc = "Neotest: Run nearest" })
map("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand "%") end, { desc = "Neotest: Run file" })
map("n", "<leader>ts", function() require("neotest").summary.toggle() end, { desc = "Neotest: Summary" })
map("n", "<leader>to", function() require("neotest").output_panel.toggle() end, { desc = "Neotest: Output" })
map("n", "<leader>tS", function() require("neotest").run.stop() end, { desc = "Neotest: Stop" })
map("n", "]t", function() require("neotest").jump.next { status = "failed" } end, { desc = "Neotest: Next failed" })
map("n", "[t", function() require("neotest").jump.prev { status = "failed" } end, { desc = "Neotest: Prev failed" })
