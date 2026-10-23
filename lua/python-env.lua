local M = {}

local root_markers = {
  "pyproject.toml",
  "pytest.ini",
  "Pipfile",
  "poetry.lock",
  "uv.lock",
  "mypy.ini",
  ".mypy.ini",
  "setup.py",
  "setup.cfg",
  ".git",
}

function M.root(path)
  path = path or vim.api.nvim_buf_get_name(0)
  if path == "" then
    return vim.fn.getcwd()
  end

  return vim.fs.root(path, root_markers) or (vim.fn.isdirectory(path) == 1 and path or vim.fs.dirname(path))
end

local function managed_python(root, marker, command)
  if vim.fn.filereadable(root .. "/" .. marker) == 0 or vim.fn.executable(command[1]) == 0 then
    return nil
  end

  local result = vim.system(command, { cwd = root, text = true }):wait(2000)
  if result and result.code == 0 then
    local python = vim.trim(result.stdout or "")
    if vim.fn.executable(python) == 1 then
      return python
    end
  end
end

function M.resolve(path)
  for _, env in ipairs { vim.env.VIRTUAL_ENV or "", vim.env.CONDA_PREFIX or "" } do
    if env ~= "" and vim.fn.executable(env .. "/bin/python") == 1 then
      return env .. "/bin/python"
    end
  end

  local root = M.root(path)
  for _, name in ipairs { ".venv", "venv", "env", ".env" } do
    local python = root .. "/" .. name .. "/bin/python"
    if vim.fn.executable(python) == 1 then
      return python
    end
  end

  local managed = managed_python(root, "poetry.lock", { "poetry", "env", "info", "--executable" })
    or managed_python(root, "Pipfile", { "pipenv", "--py" })
  if managed then
    return managed
  end

  local python = vim.fn.exepath "python3"
  return python ~= "" and python or "python3"
end

return M
