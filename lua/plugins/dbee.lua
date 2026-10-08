local dbee = require "dbee"
local sources = require "dbee.sources"

local function unquote(value)
  value = vim.trim(value)
  local first, last = value:sub(1, 1), value:sub(-1, -1)
  if (first == '"' and last == '"') or (first == "'" and last == "'") then
    return value:sub(2, -2)
  end
  return value
end

local function database_type(url)
  local scheme = url:match "^([%w+.-]+):"
  return ({ postgresql = "postgres", postgres = "postgres" })[scheme] or scheme or "postgres"
end

local function disable_postgres_ssl(url)
  local scheme = url:match "^([%w+.-]+):"
  if scheme ~= "postgres" and scheme ~= "postgresql" then
    return url
  end

  local updated, count = url:gsub("([?&])sslmode=[^&#]*", "%1sslmode=disable", 1)
  if count > 0 then
    return updated
  end

  local fragment = ""
  local without_fragment, suffix = url:match "^(.-)(#.*)$"
  if without_fragment then
    url, fragment = without_fragment, suffix
  end

  return url .. (url:find "?" and "&" or "?") .. "sslmode=disable" .. fragment
end

local function project_connections()
  local root = vim.fs.root(0, { ".env", ".git", "pyproject.toml", "package.json" }) or vim.fn.getcwd()
  local env_file = root .. "/.env"
  local values = {}

  if vim.fn.filereadable(env_file) == 1 then
    for _, line in ipairs(vim.fn.readfile(env_file)) do
      local key, value = line:match [[^%s*([%w_]+)%s*=%s*(.-)%s*$]]
      if key and value then
        values[key] = unquote(value)
      end
    end
  end

  local project = vim.fn.fnamemodify(root, ":t")
  local connections, seen = {}, {}

  local function add(name, url)
    if url and url ~= "" and not seen[name] then
      seen[name] = true
      table.insert(connections, {
        id = project .. "-" .. name,
        name = name,
        type = database_type(url),
        url = disable_postgres_ssl(url),
      })
    end
  end

  add(values.DATABASE_NAME or project, values.DATABASE_URL or values.DB_URL or values.POSTGRES_URL or values.MYSQL_URL)

  for key, url in pairs(values) do
    local name = key:match "^DB_UI_(.+)$" or key:match "^DBEE_(.+)$"
    if name then
      add(name:lower(), url)
    end
  end

  return connections
end

local function refresh_env_source()
  vim.env.DBEE_CONNECTIONS = vim.json.encode(project_connections())

  if dbee.api.core.is_loaded() then
    dbee.api.core.source_reload "DBEE_CONNECTIONS"
    pcall(dbee.api.ui.drawer_refresh)
  end
end

refresh_env_source()

dbee.setup {
  sources = {
    sources.EnvSource:new "DBEE_CONNECTIONS",
    sources.FileSource:new(vim.fn.stdpath "data" .. "/dbee/persistence.json"),
  },
}

vim.api.nvim_create_user_command("DbeeReloadEnv", function()
  refresh_env_source()
  vim.notify("Reloaded dbee connections from the project .env", vim.log.levels.INFO)
end, { desc = "Reload dbee connections from the project .env" })

vim.api.nvim_create_autocmd("DirChanged", {
  callback = refresh_env_source,
  desc = "Refresh dbee connections after changing project",
})

vim.api.nvim_create_user_command("DbeeInstall", function()
  dbee.install()
end, { desc = "Install or update the dbee database backend" })

vim.keymap.set("n", "<leader>db", function()
  dbee.toggle()
end, { desc = "Database: Toggle dbee workspace" })

vim.keymap.set("n", "<leader>do", function()
  dbee.open()
end, { desc = "Database: Open dbee workspace" })
