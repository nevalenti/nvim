local map = vim.keymap.set
local lazy = require "lazy-load"

require("neotest").setup {
  adapters = {
    require "neotest-python" {
      runner = "pytest",
      python = function(root)
        return require("python-env").resolve(root)
      end,
    },
    require "neotest-vitest",
    require "neotest-jest" { jestCommand = "npx jest --" },
    require "neotest-dotnet" { dap = { adapter_name = "coreclr" } },
    require "neotest-phpunit" { dap = { type = "php", request = "launch", name = "Listen for Xdebug", port = 9003 } },
  },
  output = { open_on_run = true },
}

map("n", "<leader>t", function()
  require("neotest").run.run()
end, { desc = "Neotest: Run nearest" })
map("n", "<leader>tr", function()
  require("neotest").run.run()
end, { desc = "Neotest: Run nearest" })
map("n", "<leader>tf", function()
  require("neotest").run.run(vim.fn.expand "%")
end, { desc = "Neotest: Run file" })
map("n", "<leader>td", function()
  lazy.load "dap"
  require("neotest").run.run { strategy = "dap" }
end, { desc = "Neotest: Debug nearest" })
map("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end, { desc = "Neotest: Summary" })
map("n", "<leader>to", function()
  require("neotest").output_panel.toggle()
end, { desc = "Neotest: Output" })
map("n", "<leader>tS", function()
  require("neotest").run.stop()
end, { desc = "Neotest: Stop" })
map("n", "]n", function()
  require("neotest").jump.next { status = "failed" }
end, { desc = "Neotest: Next failed" })
map("n", "[n", function()
  require("neotest").jump.prev { status = "failed" }
end, { desc = "Neotest: Prev failed" })
