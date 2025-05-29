require "nvchad.options"

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true

vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.termguicolors = true

vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.inccommand = 'split'
vim.opt.isfname:append '@-@'

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.timeoutlen = 300
vim.opt.updatetime = 250
vim.opt.ttyfast = true

vim.opt.breakindent = true

vim.opt.title = true
vim.opt.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a'

