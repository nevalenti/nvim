vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/VonHeikemen/lsp-zero.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lua" },
  { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nosduco/remote-sshfs.nvim" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/echasnovski/mini.icons" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/folke/trouble.nvim" },
  { src = "https://github.com/mbbill/undotree" },
  { src = "https://github.com/tpope/vim-commentary" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/nevalenti/gruber-darker.nvim" },
})

require('options')
require('mappings')
require('autocommands')
require('theme')

require('plugins.lsp')
require('plugins.telescope')
require('plugins.oil')
require('plugins.trouble')
require('plugins.gitsigns')
require('plugins.undotree')
require('plugins.vim-commentary')
require('plugins.mini-icons')

