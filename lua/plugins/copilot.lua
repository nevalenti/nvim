vim.g.copilot_no_tab_map = true

local map = vim.keymap.set

local function copilot_accept()
  return vim.fn['copilot#Accept']('<CR>')
end

map('i', '<C-J>', copilot_accept, {
  expr = true,
  replace_keycodes = false,
  silent = true,
  desc = 'Copilot: Accept suggestion',
})

map('i', '<C-]>', vim.fn['copilot#Next'], {
  silent = true,
  desc = 'Copilot: Next suggestion',
})

map('i', '<C-[>', vim.fn['copilot#Previous'], {
  silent = true,
  desc = 'Copilot: Previous suggestion',
})

map('i', '<C-\\>', vim.fn['copilot#Dismiss'], {
  silent = true,
  desc = 'Copilot: Dismiss panel',
})
