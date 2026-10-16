local map = vim.keymap.set
local refactoring = require "refactoring"

map({ "n", "x" }, "<leader>rs", refactoring.select_refactor, { desc = "Refactor: Select refactor" })

map({ "n", "x" }, "<leader>re", function()
  return refactoring.extract_func()
end, { expr = true, desc = "Refactor: Extract function" })

map({ "n", "x" }, "<leader>rv", function()
  return refactoring.extract_var()
end, { expr = true, desc = "Refactor: Extract variable" })

map({ "n", "x" }, "<leader>ri", function()
  return refactoring.inline_var()
end, { expr = true, desc = "Refactor: Inline variable" })
