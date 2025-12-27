local lsp = require('lsp-zero')
local cmp = require('cmp')

local map = vim.keymap.set

require("mason").setup {}
require('mason-lspconfig').setup({
  ensure_installed = {
    'csharp_ls',
    'gopls',
    'pyright',
    'ruff',
    'ts_ls',
    'lua_ls',
    'html',
    'cssls',
    'tailwindcss',
    'jsonls',
    'lemminx',
    'yamlls',
    'taplo',
  },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,

    lua_ls = function()
      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
    end,
  },
})
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'c_sharp',
    'python',
    'go',
    'gomod',
    'gowork',
    'gosum',
    'javascript',
    'typescript',
    'lua',
    'html',
    'css',
    'json',
    'xml',
    'yaml',
    'toml',
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

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
  map("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
  map("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
  map("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
  },
})
