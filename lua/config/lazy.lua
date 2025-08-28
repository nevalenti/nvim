-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set up Lazy.nvim
require("lazy").setup({
  -- Syntax and Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function() require("plugins.treesitter") end },

  -- LSP and Completion
  { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
  { "neovim/nvim-lspconfig", config = function() require("plugins.lsp") end },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-nvim-lua" },
  { "saadparwaiz1/cmp_luasnip" },
  { "L3MON4D3/LuaSnip" },
  { "rafamadriz/friendly-snippets" },

  -- Telescope
  { "nvim-telescope/telescope.nvim", config = function() require("plugins.telescope") end },
  { "nvim-lua/plenary.nvim" },

  -- File and Project Management
  { "nosduco/remote-sshfs.nvim" },
  { "stevearc/oil.nvim", config = function() require("plugins.oil") end },

  -- Diagnostics and Git
  { "folke/trouble.nvim", config = function() require("plugins.trouble") end },
  { "lewis6991/gitsigns.nvim", config = function() require("plugins.gitsigns") end },
  { "tpope/vim-fugitive" },

  -- Utilities
  { "mbbill/undotree", config = function() require("plugins.undotree") end },
  { "echasnovski/mini.icons", config = function() require("plugins.mini-icons") end },
  { "tpope/vim-commentary", config = function() require("plugins.vim-commentary") end },
  { "folke/which-key.nvim" },

  -- Theme
  { "nevalenti/gruber-darker.nvim" },
}, {
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
})