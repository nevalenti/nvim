vim.pack.add {
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/echasnovski/mini.icons" },

  { src = "https://github.com/nevalenti/gruber-darker.nvim" },

  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/rcarriga/nvim-notify" },
  { src = "https://github.com/folke/noice.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/stevearc/dressing.nvim" },
  { src = "https://github.com/j-hui/fidget.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },

  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/refractalize/oil-git-status.nvim" },
  { src = "https://github.com/mbbill/undotree" },

  { src = "https://github.com/nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/VonHeikemen/lsp-zero.nvim" },
  { src = "https://github.com/saghen/blink.cmp", build = "cargo build --release" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },

  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/sindrets/diffview.nvim" },

  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/jay-babu/mason-nvim-dap.nvim" },
  { src = "https://github.com/rcarriga/nvim-dap-ui" },
  { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
  { src = "https://github.com/leoluz/nvim-dap-go" },
  { src = "https://github.com/mfussenegger/nvim-dap-python" },

  { src = "https://github.com/tpope/vim-commentary" },
  { src = "https://github.com/tpope/vim-surround" },
  { src = "https://github.com/m4xshen/autoclose.nvim" },

  { src = "https://github.com/yetone/avante.nvim", build = "make" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", ft = { "markdown" } },

  { src = "https://github.com/folke/trouble.nvim" },
}

require "options"
require "diagnostics"
require "mappings"
require "autocommands"

require "theme"
require "plugins.mini-icons"
require "plugins.noice"
require "plugins.notify"
require "plugins.statusline"
require "plugins.which-key"

require "plugins.oil"
require "plugins.telescope"
require "plugins.undotree"

require "plugins.lsp"

require "plugins.trouble"

require "plugins.gitsigns"

require "plugins.dap"

require "plugins.autoclose"

require "plugins.avante"
require "plugins.render-markdown"
