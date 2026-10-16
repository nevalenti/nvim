local overseer = require "overseer"

overseer.setup { dap = false }

local map = vim.keymap.set

map("n", "<leader>pr", "<cmd>OverseerRun<CR>", { desc = "Overseer: Run project task" })
map("n", "<leader>pt", "<cmd>OverseerToggle<CR>", { desc = "Overseer: Toggle task list" })
map("n", "<leader>pc", "<cmd>OverseerShell<CR>", { desc = "Overseer: Run shell command as task" })
map("n", "<leader>pl", function()
  local task = overseer.list_tasks()[1]
  if task then
    overseer.run_action(task, "restart")
  else
    vim.notify("No tasks to restart", vim.log.levels.WARN)
  end
end, { desc = "Overseer: Restart last task" })
