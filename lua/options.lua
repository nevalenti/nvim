vim.g.mapleader = " "
vim.g.loaded_matchparen = 1

vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a'
vim.opt.laststatus = 3
vim.opt.showmode = false

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.scrolloff = 8
vim.opt.isfname:append "@-@"

vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.inccommand = "split"

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.clipboard = "unnamedplus"

vim.opt.timeoutlen = 300
vim.opt.updatetime = 250

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.mouse = "a"
