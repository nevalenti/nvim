local Terminal = require("toggleterm.terminal").Terminal

local function shell_command(command)
  local terminal = Terminal:new {
    cmd = command,
    direction = "float",
    close_on_exit = false,
  }
  terminal:toggle()
end

local function run_prompt(prompt, default)
  local command = vim.fn.input(prompt, default or "")
  if command ~= "" then
    shell_command(command)
  end
end

local function project_python()
  return vim.fn.shellescape(require("python-env").resolve())
end

vim.keymap.set("n", "<leader>x", "<Nop>", { desc = "Backend commands" })

vim.keymap.set("n", "<leader>xa", function()
  run_prompt("HTTP request: ", "curl -i ")
end, { desc = "Backend: Run curl HTTP request" })

vim.keymap.set("n", "<leader>xu", function()
  shell_command "docker compose up -d"
end, { desc = "Docker: Start Compose services" })
vim.keymap.set("n", "<leader>xd", function()
  shell_command "docker compose down"
end, { desc = "Docker: Stop and remove Compose services" })
vim.keymap.set("n", "<leader>xdv", function()
  shell_command "docker compose down -v"
end, { desc = "Docker: Stop services and remove volumes" })
vim.keymap.set("n", "<leader>xl", function()
  shell_command "docker compose logs -f --tail=100"
end, { desc = "Docker: Follow recent Compose logs" })
vim.keymap.set("n", "<leader>xe", function()
  local service = vim.fn.input "Compose service: "
  if service ~= "" then
    shell_command("docker compose exec " .. vim.fn.shellescape(service) .. " sh")
  end
end, { desc = "Docker: Open shell in Compose service" })

vim.keymap.set("n", "<leader>xc", function()
  shell_command(project_python() .. " -m pytest --cov --cov-report=term-missing")
end, { desc = "Python: Run pytest with coverage" })
vim.keymap.set("n", "<leader>xm", function()
  run_prompt("Migration command: ", project_python() .. " -m alembic upgrade head")
end, { desc = "Backend: Run database migrations" })
vim.keymap.set("n", "<leader>xs", function()
  run_prompt("Server command: ", project_python() .. " -m uvicorn app:app --reload")
end, { desc = "Backend: Start development server" })

vim.keymap.set("n", "<leader>xA", function()
  shell_command(project_python() .. " -m pip_audit")
end, { desc = "Python: Audit dependency vulnerabilities" })
vim.keymap.set("n", "<leader>xb", function()
  shell_command(project_python() .. " -m bandit -r .")
end, { desc = "Python: Scan code with Bandit" })
vim.keymap.set("n", "<leader>xS", function()
  run_prompt("Security command: ", "semgrep --config auto .")
end, { desc = "Backend: Run Semgrep security scan" })

vim.keymap.set("n", "<leader>xp", function()
  local command = vim.fn.executable "direnv" == 1 and "direnv exec . $SHELL" or "$SHELL"
  shell_command(command)
end, { desc = "Backend: Open environment-aware shell" })
