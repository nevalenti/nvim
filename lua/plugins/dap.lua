require('nvim-dap-virtual-text').setup {}

local dap = require('dap')
local dapui = require('dapui')
dapui.setup {}

local map = vim.keymap.set

map('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
map('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
map('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
map('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
map('n', '<Leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
map('n', '<Leader>B', function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = 'Debug: Set Conditional Breakpoint' })

dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

dap.adapters.netcoredbg = {
  type = 'executable',
  command = 'netcoredbg',
  args = { '--interpreter=vscode' },
}
dap.configurations.cs = {
  {
    type = 'netcoredbg',
    name = 'Launch - netcoredbg',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to DLL: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = false,
    console = 'internalConsole',
  },
  {
    type = 'netcoredbg',
    name = 'Attach - netcoredbg',
    request = 'attach',
    processId = function()
      return vim.fn.input('Process ID: ')
    end,
  },
}

require('dap-go').setup {}

dap.adapters.python = {
  type = 'executable',
  command = 'python',
  args = { '-m', 'debugpy.adapter' },
}
dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    pythonPath = function()
      return 'python'
    end,
  },
}
