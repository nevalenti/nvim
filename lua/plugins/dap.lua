require("nvim-dap-virtual-text").setup {
  enabled = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = true,
  show_stop_reason = true,
  virt_text_pos = "eol",
  all_frames = false,
}

local dap = require "dap"
local dapui = require "dapui"

vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = require("theme-palette").red })
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })

dapui.setup {
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        { id = "repl", size = 0.5 },
        { id = "console", size = 0.5 },
      },
      size = 10,
      position = "bottom",
    },
  },
}

local map = vim.keymap.set

map("n", "<F5>", dap.continue, { desc = "Debug: Start or continue" })
map("n", "<F10>", dap.step_over, { desc = "Debug: Step over" })
map("n", "<F11>", dap.step_into, { desc = "Debug: Step into" })
map("n", "<F12>", dap.step_out, { desc = "Debug: Step out" })
map("n", "<Leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle breakpoint" })
map("n", "<Leader>B", function()
  dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
end, { desc = "Debug: Set conditional breakpoint" })

map("n", "<Leader>du", dapui.toggle, { desc = "Debug: Toggle debugger UI" })
map("n", "<Leader>dt", dap.terminate, { desc = "Debug: Terminate session" })
map("n", "<Leader>de", dapui.eval, { desc = "Debug: Evaluate expression under cursor" })
map("v", "<Leader>de", dapui.eval, { desc = "Debug: Evaluate selection" })
map("n", "<Leader>dC", dap.run_to_cursor, { desc = "Debug: Run to cursor" })
map("n", "<Leader>dr", dap.restart, { desc = "Debug: Restart session" })
map("n", "<Leader>dl", dap.run_last, { desc = "Debug: Rerun last configuration" })

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

dap.adapters.coreclr = {
  type = "executable",
  command = (function()
    local mason_netcoredbg = vim.fn.stdpath "data" .. "/mason/bin/netcoredbg"
    return vim.fn.executable(mason_netcoredbg) == 1 and mason_netcoredbg or "netcoredbg"
  end)(),
  args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "Launch - netcoredbg",
    request = "launch",
    program = function()
      local cwd = vim.fn.getcwd()
      local debug_paths = {
        cwd .. "/bin/Debug/",
        cwd .. "/bin/x64/Debug/",
        cwd .. "/bin/",
      }

      local default_path = cwd
      for _, path in ipairs(debug_paths) do
        if vim.fn.isdirectory(path) == 1 then
          default_path = path
          break
        end
      end

      return vim.fn.input("Path to DLL: ", default_path, "file")
    end,
    env = {
      ASPNETCORE_ENVIRONMENT = "Development",
      ASPNETCORE_URLS = "http://localhost:5000",
    },
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
    justMyCode = false,
  },
  {
    type = "coreclr",
    name = "Attach - netcoredbg",
    request = "attach",
    processId = function()
      return vim.fn.input "Process ID: "
    end,
  },
}

require("dap-go").setup {}

local dap_python = require "dap-python"
local python_env = require "python-env"
dap_python.resolve_python = function()
  return python_env.resolve()
end
dap_python.setup(vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python")

for _, config in ipairs(dap.configurations.python) do
  if config.request == "launch" then
    config.cwd = function()
      return python_env.root()
    end
  end
end

local fastapi_apps = {}

local function fastapi_app()
  local root = python_env.root()
  local file = vim.api.nvim_buf_get_name(0)
  local relative = vim.fs.relpath(root .. "/src", file) or vim.fs.relpath(root, file)
  local default = "app:app"
  if relative and relative:match "%.py$" then
    default = relative:gsub("/__init__%.py$", ""):gsub("%.py$", ""):gsub("/", ".") .. ":app"
  end

  local app = vim.fn.input("FastAPI app (module:variable): ", fastapi_apps[root] or default)
  if app ~= "" then
    fastapi_apps[root] = app
  end
  return app ~= "" and app or (fastapi_apps[root] or default)
end

table.insert(dap.configurations.python, {
  type = "python",
  request = "launch",
  name = "FastAPI (uvicorn)",
  module = "uvicorn",
  args = function()
    return { fastapi_app(), "--host", "127.0.0.1", "--port", "8000" }
  end,
  cwd = function()
    return python_env.root()
  end,
  pythonPath = function()
    return python_env.resolve()
  end,
  console = "integratedTerminal",
})

dap.listeners.on_config["python.neotest_cwd"] = function(config)
  if config.type == "python" and config.name == "Neotest Debugger" and config.args then
    local test_id = config.args[#config.args]
    if type(test_id) == "string" then
      local test_file = test_id:match "^(.-)::" or test_id
      if vim.fn.filereadable(test_file) == 1 then
        config.cwd = python_env.root(test_file)
      end
    end
  end
  return config
end

local python_test_opts = {
  test_runner = "pytest",
  config = {
    cwd = function()
      return python_env.root()
    end,
  },
}
map("n", "<Leader>dm", function()
  dap_python.test_method(python_test_opts)
end, { desc = "Debug: Nearest Python test method" })
map("n", "<Leader>dc", function()
  dap_python.test_class(python_test_opts)
end, { desc = "Debug: Nearest Python test class" })

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = {
      vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
      "${port}",
    },
  },
}

dap.adapters["pwa-chrome"] = dap.adapters["pwa-node"]

local js_ts_configs = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch current file (Node.js)",
    program = "${file}",
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
    skipFiles = { "<node_internals>/**", "node_modules/**" },
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach to Node.js process",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    skipFiles = { "<node_internals>/**", "node_modules/**" },
  },
  {
    type = "pwa-chrome",
    request = "launch",
    name = "Next.js: Debug Client (Chrome)",
    url = "http://localhost:3000",
    webRoot = "${workspaceFolder}",
    sourceMaps = true,
    userDataDir = false,
  },
  {
    type = "pwa-node",
    request = "launch",
    name = "Next.js: Debug Server",
    runtimeExecutable = "node",
    runtimeArgs = {
      "--inspect",
      "./node_modules/next/dist/bin/next",
      "dev",
    },
    cwd = "${workspaceFolder}",
    env = {
      NODE_OPTIONS = "--inspect",
    },
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
    skipFiles = { "<node_internals>/**", "node_modules/**" },
    resolveSourceMapLocations = {
      "${workspaceFolder}/**",
      "!**/node_modules/**",
    },
  },
  {
    type = "pwa-chrome",
    request = "launch",
    name = "Launch Chrome (localhost:3000)",
    url = "http://localhost:3000",
    webRoot = "${workspaceFolder}",
    sourceMaps = true,
  },
}

for _, lang in ipairs { "javascript", "typescript", "javascriptreact", "typescriptreact" } do
  dap.configurations[lang] = js_ts_configs
end

dap.adapters.php = {
  type = "executable",
  command = "node",
  args = { vim.fn.stdpath "data" .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js" },
}

dap.configurations.php = {
  {
    type = "php",
    request = "launch",
    name = "Listen for Xdebug",
    port = 9003,
  },
}
