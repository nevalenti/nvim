vim.pack.add({
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/kevinhwang91/rnvimr" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/mbbill/undotree" },
  { src = "https://github.com/folke/trouble.nvim" },
  { src = "https://github.com/nevalenti/gruber-darker.nvim" },

  { src = "https://github.com/VonHeikemen/lsp-zero.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },

  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lua" },

  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
})

require("mason").setup {}
require("telescope").setup {}
require("trouble").setup {}
require("oil").setup {}

vim.g.mapleader = " "

vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a'

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

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.clipboard = "unnamedplus"

vim.opt.timeoutlen = 300
vim.opt.updatetime = 250
vim.opt.ttyfast = true

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.mouse = "a"
vim.opt.inccommand = "split"

local map = vim.keymap.set
local builtin = require('telescope.builtin')

map("n", "<Space>", "<Nop>", { silent = true, desc = "Disable space" })
map("n", ";", ":", { desc = "Command mode" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("n", "<Esc>", "<CMD>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader><CR>", ":cd %:h<CR>", { desc = "Set CWD to current file" })

map('n', '<leader>o', ':update<CR>:source<CR>', { desc = "Save and source" })
map('n', '<leader>w', ':write<CR>', { desc = "Save file" })
map('n', '<leader>q', ':quit<CR>', { desc = "Quit" })

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move to window below" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move to window above" })

map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
map("n", "n", "nzzzv", { desc = "Center search result" })
map("n", "N", "Nzzzv", { desc = "Center previous search result" })
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

map("n", "<leader>e", ":Oil<CR>", { desc = "Toggle Oil file explorer" })
map("n", "<leader>pv", ":RnvimrToggle<CR>", { desc = "Toggle Ranger file explorer" })
map("n", "<leader>f", vim.lsp.buf.format, { desc = "Format buffer" })
map('n', '<leader>ff', builtin.find_files, { desc = "Telescope: Find files" })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
map("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "Toggle undotree" })
map("n", "<leader>xx", "<CMD>Trouble diagnostics toggle<CR>", { desc = "Toggle Trouble" })

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local text_yank_group = augroup("TextYank", {})
local buf_write_pre_group = vim.api.nvim_create_augroup("BufWritePreGroup", { clear = true })

autocmd("TextYankPost", {
  group = text_yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "IncSearch",
      timeout = 250,
    }
  end,
})

autocmd("BufWritePre", {
  group = buf_write_pre_group,
  pattern = "*",
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if vim.bo.filetype ~= "oil" and not bufname:match("^oil://") then
      vim.cmd([[%s/\s\+$//e]])
    end
  end,
})

local lsp = require('lsp-zero')

lsp.on_attach(function(_, bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  local lsp_names = {}
  for _, client in ipairs(clients) do
    table.insert(lsp_names, client.name)
  end

  vim.cmd("highlight GreenText guifg=#00FF00")

  -- local lsp_name_str = table.concat(lsp_names, ", ")
  -- vim.api.nvim_echo({
  -- { "LSP " .. lsp_name_str .. " attached to buffer: " .. vim.api.nvim_buf_get_name(bufnr) .. "\n", "GreenText" }
  -- }, true, {})

  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.jump_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.jump_prev() end, opts)
  vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

require('mason-lspconfig').setup({
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
        on_attach = lsp.on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })
    end,
  },
})

local cmp = require('cmp')

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = nil,
    ['<S-Tab>'] = nil,
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
  },
})

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = 'E',
      [vim.diagnostic.severity.WARN] = 'W',
      [vim.diagnostic.severity.HINT] = 'H',
      [vim.diagnostic.severity.INFO] = 'I',
    },
    active = true,
    priority = 20,
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    header = "",
    prefix = "",
  },
})

require 'nvim-treesitter.configs'.setup {
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

vim.g.rnvimr_enable_ex = 1
vim.g.rnvimr_enable_picker = 1
vim.g.rnvimr_layout = {
  relative = "editor",
  width = vim.o.columns - 2,
  height = vim.o.lines - 2,
  col = 0,
  row = 0,
  style = "minimal",
}

vim.cmd.colorscheme("gruber-darker")
vim.cmd(":hi statusline guibg=NONE")
