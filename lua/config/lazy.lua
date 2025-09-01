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

require("lazy").setup({
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function() end
  },

  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x"
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lsp = require('lsp-zero')
      local cmp = require('cmp')
      local map = vim.keymap.set

      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
      require("mason").setup {}
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

      lsp.on_attach(function(_, bufnr)
        local clients = vim.lsp.get_clients({ bufnr = bufnr })

        local lsp_names = {}
        for _, client in ipairs(clients) do
          table.insert(lsp_names, client.name)
        end

        local opts = { buffer = bufnr, remap = false }

        map("n", "gd", function() vim.lsp.buf.definition() end, opts)
        map("n", "K", function() vim.lsp.buf.hover() end, opts)
        map("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
        map("n", "<leader>d", function() vim.diagnostic.open_float() end, opts)
        map("n", "[d", function() vim.diagnostic.jump_next() end, opts)
        map("n", "]d", function() vim.diagnostic.jump_prev() end, opts)
        map("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        map("n", "<leader>grr", function() vim.lsp.buf.references() end, opts)
        map("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
        map("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
      end)

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

      require 'nvim-treesitter.configs'.setup {
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
    end
  },
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
  {
    "folke/trouble.nvim",
    config = function()
      require('trouble').setup {}

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
    end
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = 'make'
    },
    config = function()
      require('telescope').setup {
        defaults = {
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              width = { padding = 0 },
              height = { padding = 0 },
              preview_width = 0.5,
            },
          },
        },
      }
      require('telescope').load_extension('fzf')
    end
  },
  { "nvim-lua/plenary.nvim" },
  {
    "stevearc/oil.nvim",
    dependencies = { "https://github.com/refractalize/oil-git-status.nvim" },
    config = function()
      require('oil').setup {
        columns = {
          "icon",
          "permissions",
          "size",
          "mtime",
        },
        view_options = {
          show_hidden = true
        },
        win_options = {
          signcolumn = "yes:2",
        }
      }
      require("oil-git-status").setup {}
    end
  },

  { "tpope/vim-fugitive" },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
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
    end
  },
  { "sindrets/diffview.nvim" },

  { "tpope/vim-commentary" },
  { "tpope/vim-surround" },
  {
    "m4xshen/autoclose.nvim",
    config = function() require('autoclose').setup {} end
  },
  { "mbbill/undotree" },

  { "echasnovski/mini.icons" },
  { "nvim-tree/nvim-web-devicons" },
  { "folke/which-key.nvim" },
  {
    "https://github.com/nvim-lualine/lualine.nvim",
    config = function()
      local theme = {
        normal = {
          a = { fg = '#E4E4E4', bg = '#9F84FF', gui = 'bold' },
          b = { fg = '#E4E4E4', bg = '#453D41' },
          c = { fg = '#E4E4E4', bg = '#121212' },
        },
        insert = {
          a = { fg = '#121212', bg = '#73D936', gui = 'bold' },
          b = { fg = '#E4E4E4', bg = '#453D41' },
          c = { fg = '#E4E4E4', bg = '#121212' },
        },
        visual = {
          a = { fg = '#121212', bg = '#FFDD33', gui = 'bold' },
          b = { fg = '#E4E4E4', bg = '#453D41' },
          c = { fg = '#E4E4E4', bg = '#121212' },
        },
        replace = {
          a = { fg = '#121212', bg = '#F43841', gui = 'bold' },
          b = { fg = '#E4E4E4', bg = '#453D41' },
          c = { fg = '#E4E4E4', bg = '#121212' },
        },
        command = {
          a = { fg = '#121212', bg = '#B584FF', gui = 'bold' },
          b = { fg = '#E4E4E4', bg = '#453D41' },
          c = { fg = '#E4E4E4', bg = '#121212' },
        },
        inactive = {
          a = { fg = '#E4E4E4', bg = '#101010', gui = 'bold' },
          b = { fg = '#E4E4E4', bg = '#101010' },
          c = { fg = '#E4E4E4', bg = '#101010' },
        },
      }

      require('lualine').setup {
        options = { theme = theme },
      }
    end
  },

  { "nevalenti/gruber-darker.nvim" },
}, {
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
})
