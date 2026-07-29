local M = {}

M.groups = {
  avante = {
    { src = "https://github.com/yetone/avante.nvim", build = "make" },
  },
  telescope = {
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { src = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim" },
  },
  oil = {
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/refractalize/oil-git-status.nvim" },
  },
  dap = {
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/jay-babu/mason-nvim-dap.nvim" },
    { src = "https://github.com/rcarriga/nvim-dap-ui" },
    { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
    { src = "https://github.com/leoluz/nvim-dap-go" },
    { src = "https://github.com/mfussenegger/nvim-dap-python" },
  },
  neotest = {
    { src = "https://github.com/nvim-neotest/neotest" },
    { src = "https://github.com/marilari88/neotest-vitest" },
    { src = "https://github.com/nvim-neotest/neotest-jest" },
    { src = "https://github.com/Issafalcon/neotest-dotnet" },
  },
  harpoon = {
    { src = "https://github.com/ThePrimeagen/harpoon", branch = "harpoon2" },
  },
  diffview = {
    { src = "https://github.com/sindrets/diffview.nvim" },
  },
  trouble = {
    { src = "https://github.com/folke/trouble.nvim" },
  },
  ["zen-mode"] = {
    { src = "https://github.com/folke/zen-mode.nvim" },
    { src = "https://github.com/folke/twilight.nvim" },
  },
}

local loaded = {}

function M.load(name)
  if loaded[name] then
    return
  end
  loaded[name] = true
  vim.pack.add(M.groups[name], { load = true })
  require("plugins." .. name)
end

function M.on_keys(name, keys)
  local function trigger(lhs)
    for _, key in ipairs(keys) do
      pcall(vim.keymap.del, key[1], key[2])
    end
    M.load(name)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(lhs, true, true, true), "m", false)
  end

  for _, key in ipairs(keys) do
    local mode, lhs = key[1], key[2]
    vim.keymap.set(mode, lhs, function()
      trigger(lhs)
    end, { desc = "Load " .. name })
  end
end

function M.on_cmd(name, pattern)
  vim.api.nvim_create_autocmd("CmdUndefined", {
    pattern = pattern,
    callback = function()
      M.load(name)
    end,
  })
end

return M
