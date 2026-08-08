vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_show_help = 0
vim.g.db_ui_win_position = "left"
vim.g.db_ui_winwidth = 40

local function project_dbs()
  local cwd = vim.fn.getcwd()
  local env_file = cwd .. "/.env"
  if vim.fn.filereadable(env_file) == 0 then
    return {}
  end
  for _, line in ipairs(vim.fn.readfile(env_file)) do
    local url = line:match "^DATABASE_URL=(.+)$"
    if url then
      return { { name = vim.fn.fnamemodify(cwd, ":t"), url = url } }
    end
  end
  return {}
end

vim.g.dbs = project_dbs()

local map = vim.keymap.set

map("n", "<leader>du", "<cmd>DBUIToggle<CR>", { desc = "DB: Toggle UI" })
map("n", "<leader>df", "<cmd>DBUIFindBuffer<CR>", { desc = "DB: Find buffer" })
map("n", "<leader>dr", "<cmd>DBUIRenameBuffer<CR>", { desc = "DB: Rename buffer" })
map("n", "<leader>dq", "<cmd>DBUILastQueryInfo<CR>", { desc = "DB: Last query info" })
