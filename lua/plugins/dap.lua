local mason_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"

require('nvim-dap-virtual-text').setup {
  enabled = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = true,
  show_stop_reason = true,
  virt_text_pos = 'eol',
  all_frames = false,
}

local dap = require('dap')
local dapui = require('dapui')

dapui.setup {
  layouts = {
    {
      elements = {
        { id = "scopes",      size = 0.25 },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks",      size = 0.25 },
        { id = "watches",     size = 0.25 },
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        { id = "repl",    size = 0.5 },
        { id = "console", size = 0.5 },
      },
      size = 10,
      position = "bottom",
    },
  },
}

local map = vim.keymap.set

map('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
map('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
map('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
map('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
map('n', '<Leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
map('n', '<Leader>B', function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = 'Debug: Set Conditional Breakpoint' })

map('n', '<Leader>du', dapui.toggle, { desc = 'Debug: Toggle UI' })
map('n', '<Leader>dt', dap.terminate, { desc = 'Debug: Terminate Session' })
map('n', '<Leader>de', dapui.eval, { desc = 'Debug: Evaluate Expression (normal/visual mode)' })
map('v', '<Leader>de', dapui.eval, { desc = 'Debug: Evaluate Selection' })

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

dap.adapters.coreclr = {
  type = 'executable',
  command = 'netcoredbg',
  args = { '--interpreter=vscode' },
}

dap.configurations.cs = {
  {
    type = 'coreclr',
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
    type = 'coreclr',
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
    pythonPath = 'python',
    console = 'integratedTerminal',
  },
}

dap.adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    command = 'node',
    args = {
      mason_path .. '/js-debug/src/dapDebugServer.js',
      '${port}'
    },
  },
}

dap.adapters['pwa-chrome'] = dap.adapters['pwa-node']

local js_ts_configs = {
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch current file (Node.js)',
    program = '${file}',
    cwd = '${workspaceFolder}',
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    skipFiles = { '<node_internals>/**', 'node_modules/**' },
  },
  {
    type = 'pwa-node',
    request = 'attach',
    name = 'Attach to Node.js process',
    processId = require('dap.utils').pick_process,
    cwd = '${workspaceFolder}',
    sourceMaps = true,
    skipFiles = { '<node_internals>/**', 'node_modules/**' },
  },
  {
    type = 'pwa-chrome',
    request = 'launch',
    name = 'Launch Chrome<a href="http://localhost:3000" target="_blank" rel="noopener noreferrer nofollow"></a>',
    url = 'http://localhost:3000',
    webRoot = '${workspaceFolder}',
    sourceMaps = true,
  },
}

for _, lang in ipairs({ 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }) do
  dap.configurations[lang] = js_ts_configs
end
