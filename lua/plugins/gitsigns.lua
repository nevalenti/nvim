require("gitsigns").setup {
  signs = {
    add          = { text = '+' },
    change       = { text = '~' },
    delete       = { text = '-' },
    topdelete    = { text = '‾' },
    changedelete = { text = '≃' },
    untracked    = { text = '?' },
  },
  signs_staged = {
    add          = { text = '█' },
    change       = { text = '▒' },
    delete       = { text = '▼' },
    topdelete    = { text = '▲' },
    changedelete = { text = '■' },
    untracked    = { text = '★' },
  },
}

vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#00FF00', bold = true })
vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#FFFF00', bold = true })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#FF0000', bold = true })
vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { fg = '#FF5555', bold = true })
vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { fg = '#FFAA00', bold = true })
vim.api.nvim_set_hl(0, 'GitSignsUntracked', { fg = '#00FFFF', bold = true })
vim.api.nvim_set_hl(0, 'GitSignsStagedAdd', { fg = '#00FF00', bold = true })
vim.api.nvim_set_hl(0, 'GitSignsStagedChange', { fg = '#FFFF00', bold = true })
vim.api.nvim_set_hl(0, 'GitSignsStagedDelete', { fg = '#FF0000', bold = true })
vim.api.nvim_set_hl(0, 'GitSignsStagedTopdelete', { fg = '#FF5555', bold = true })
vim.api.nvim_set_hl(0, 'GitSignsStagedChangedelete', { fg = '#FFAA00', bold = true })
vim.api.nvim_set_hl(0, 'GitSignsStagedUntracked', { fg = '#00FFFF', bold = true })

local map = vim.keymap.set
local gitsigns = require('gitsigns')

map('n', ']c', function()
  if vim.wo.diff then
    vim.cmd.normal({ ']c', bang = true })
  else
    gitsigns.nav_hunk('next')
  end
end, { desc = 'Move to next Git hunk or diff change' })

map('n', '[c', function()
  if vim.wo.diff then
    vim.cmd.normal({ '[c', bang = true })
  else
    gitsigns.nav_hunk('prev')
  end
end, { desc = 'Move to previous Git hunk or diff change' })

map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'Stage the current hunk' })
map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'Reset the current hunk' })

map('v', '<leader>gs', function()
  gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
end, { desc = 'Stage the visually selected hunk' })

map('v', '<leader>gr', function()
  gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
end, { desc = 'Reset the visually selected hunk' })

map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'Stage all hunks in the current buffer' })
map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Reset all hunks in the current buffer' })

map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'Preview the current hunk in a floating window' })
map('n', '<leader>gi', gitsigns.preview_hunk_inline, { desc = 'Preview the current hunk inline' })

map('n', '<leader>gb', function()
  gitsigns.blame_line({ full = true })
end, { desc = 'Show blame for the current line with full commit message' })

map('n', '<leader>gd', gitsigns.diffthis, { desc = 'Open diff view of current file against Git index' })

map('n', '<leader>gD', function()
  gitsigns.diffthis('~')
end, { desc = 'Open diff view of current file against previous commit' })

map('n', '<leader>gQ', function() gitsigns.setqflist('all') end,
  { desc = 'Populate quickfix list with all hunks in repository' })
map('n', '<leader>gq', gitsigns.setqflist, { desc = 'Populate quickfix list with hunks from current buffer' })

map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle blame information for the current line' })
map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = 'Toggle word-level diff highlighting' })

map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'Select the current hunk as a text object' })
