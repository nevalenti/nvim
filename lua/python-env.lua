local M = {}

function M.resolve(path)
  for _, env in ipairs { vim.env.VIRTUAL_ENV or "", vim.env.CONDA_PREFIX or "" } do
    if env ~= "" and vim.fn.executable(env .. "/bin/python") == 1 then
      return env .. "/bin/python"
    end
  end

  path = path or vim.api.nvim_buf_get_name(0)
  local root = vim.fs.root(path, { "pyproject.toml", "ty.toml", "setup.py", "setup.cfg", ".git" })
  if root and vim.fn.executable(root .. "/.venv/bin/python") == 1 then
    return root .. "/.venv/bin/python"
  end

  local python = vim.fn.exepath "python3"
  return python ~= "" and python or "python3"
end

return M
