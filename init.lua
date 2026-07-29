vim.pack.add {
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/echasnovski/mini.icons" },
  { src = "https://github.com/echasnovski/mini.indentscope" },
  { src = "https://github.com/echasnovski/mini.cursorword" },
  { src = "https://github.com/echasnovski/mini.starter" },

  { src = "https://github.com/Mofiqul/dracula.nvim" },
  { src = "https://github.com/loctvl842/monokai-pro.nvim" },
  { src = "https://github.com/rebelot/kanagawa.nvim" },
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  { src = "https://github.com/sainnhe/gruvbox-material" },
  { src = "https://github.com/blazkowolf/gruber-darker.nvim" },
  { src = "https://github.com/Mofiqul/vscode.nvim" },
  { src = "https://github.com/nyoom-engineering/oxocarbon.nvim" },
  { src = "https://github.com/rose-pine/neovim", name = "rose-pine" },

  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/rcarriga/nvim-notify" },
  { src = "https://github.com/folke/noice.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/stevearc/dressing.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/lewis6991/satellite.nvim" },
  { src = "https://github.com/folke/persistence.nvim" },
  { src = "https://github.com/akinsho/toggleterm.nvim" },

  { src = "https://github.com/tpope/vim-dadbod" },
  { src = "https://github.com/kristijanhusak/vim-dadbod-ui" },
  { src = "https://github.com/mbbill/undotree" },

  { src = "https://github.com/nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },

  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/mfussenegger/nvim-jdtls" },
  { src = "https://github.com/seblyng/roslyn.nvim" },
  { src = "https://github.com/SmiteshP/nvim-navic" },
  { src = "https://github.com/kevinhwang91/promise-async" },
  { src = "https://github.com/kevinhwang91/nvim-ufo" },
  { src = "https://github.com/saghen/blink.cmp", build = "cargo build --release" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/stevearc/conform.nvim" },

  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },

  { src = "https://github.com/kylechui/nvim-surround" },
  { src = "https://github.com/m4xshen/autoclose.nvim" },

  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", ft = { "markdown" } },
}

require "options"
require "diagnostics"
require "mappings"
require "autocommands"

require "theme"
require "plugins.mini-icons"
require "plugins.mini-indentscope"
require "plugins.mini-cursorword"
require "plugins.mini-starter"
require "plugins.noice"

vim.schedule(function()
  require "plugins.notify"
end)
vim.schedule(function()
  require "plugins.statusline"
end)
require "plugins.which-key"
vim.schedule(function()
  require "plugins.ufo"
end)
vim.schedule(function()
  require "plugins.satellite"
end)
require "plugins.persistence"

local lazy = require "lazy-load"

lazy.on_keys("zen-mode", { { "n", "<leader>zz" } })
require "plugins.toggleterm"

lazy.on_keys("oil", {
  { "n", "<leader>e" },
  { "n", "<leader>tg" },
})
require "plugins.dadbod"
lazy.on_keys("telescope", {
  { "n", "<leader>ff" },
  { "n", "<leader>fa" },
  { "n", "<leader>fw" },
  { "n", "<leader>fb" },
  { "n", "<leader>fB" },
  { "n", "<leader>fh" },
  { "n", "<leader>fr" },
  { "n", "<leader>fgf" },
  { "n", "<leader>fgc" },
  { "n", "<leader>fgs" },
  { "n", "<leader>fgb" },
  { "n", "<leader>fls" },
  { "n", "<leader>flw" },
  { "n", "<leader>fld" },
})
require "plugins.undotree"
lazy.on_keys("harpoon", {
  { "n", "<leader>ha" },
  { "n", "<leader>hh" },
  { "n", "<leader>1" },
  { "n", "<leader>2" },
  { "n", "<leader>3" },
  { "n", "<leader>4" },
})

require "plugins.treesitter"
require "plugins.treesitter-textobjects"
require "plugins.navic"
vim.schedule(function()
  require "plugins.lsp"
end)
require "plugins.roslyn"
require "plugins.conform"

lazy.on_keys("trouble", { { "n", "<leader>tt" } })

require "plugins.gitsigns"
lazy.on_keys("diffview", {
  { "n", "<leader>gv" },
  { "n", "<leader>gh" },
  { "v", "<leader>gh" },
})

lazy.on_keys("dap", {
  { "n", "<F5>" },
  { "n", "<F10>" },
  { "n", "<F11>" },
  { "n", "<F12>" },
  { "n", "<Leader>b" },
  { "n", "<Leader>B" },
  { "n", "<Leader>du" },
  { "n", "<Leader>dt" },
  { "n", "<Leader>de" },
  { "v", "<Leader>de" },
})
lazy.on_keys("neotest", {
  { "n", "<leader>tr" },
  { "n", "<leader>tf" },
  { "n", "<leader>ts" },
  { "n", "<leader>to" },
  { "n", "<leader>tS" },
  { "n", "]t" },
  { "n", "[t" },
})

require "plugins.autoclose"
require "plugins.surround"
require "plugins.autotag"

lazy.on_keys("avante", {
  { "n", "<leader>aa" },
  { "v", "<leader>aa" },
  { "n", "<leader>az" },
  { "v", "<leader>az" },
  { "n", "<leader>an" },
  { "v", "<leader>an" },
  { "v", "<leader>ae" },
  { "n", "<leader>aS" },
  { "n", "<leader>ar" },
  { "n", "<leader>af" },
  { "n", "<leader>at" },
  { "n", "<leader>ad" },
  { "n", "<leader>aC" },
  { "n", "<leader>as" },
  { "n", "<leader>aR" },
  { "n", "<leader>a?" },
  { "n", "<leader>ah" },
  { "n", "<leader>aB" },
})
lazy.on_cmd("avante", "Avante*")

require "plugins.render-markdown"
