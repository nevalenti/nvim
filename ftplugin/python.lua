vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.tabstop = 4

local Terminal = require("toggleterm.terminal").Terminal
local python = require("python-env").resolve()
local python_dir = vim.fn.fnamemodify(python, ":h")
local repl = vim.fn.executable(python_dir .. "/ipython") == 1 and python_dir .. "/ipython" or python

local repl_terminal = Terminal:new {
  cmd = vim.fn.shellescape(repl) .. " -i",
  direction = "float",
  close_on_exit = false,
}

vim.keymap.set("n", "<leader>pi", function()
  repl_terminal:toggle()
end, { buffer = true, desc = "Python: Toggle REPL" })
