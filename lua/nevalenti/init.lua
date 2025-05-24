require 'nevalenti.opt'
require 'nevalenti.remap'
require 'nevalenti.lazy'

local augroup = vim.api.nvim_create_augroup
local yank_group = augroup('Yank', {})
local general_group = augroup('General', {})

local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 250,
    }
  end,
})

autocmd({ 'BufWritePre' }, {
  group = general_group,
  pattern = '*',
  command = [[%s/\s\+$//e]],
})
