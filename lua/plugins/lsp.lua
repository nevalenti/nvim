local lsp = require('lsp-zero')

lsp.extend_lspconfig({
  sign_icons = true,
  lsp_attach = function(client, bufnr)
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
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

require("mason").setup {}
require('mason-lspconfig').setup({
  ensure_installed = {
    'csharp_ls', 'gopls', 'pyright', 'ruff', 'ts_ls',
    'lua_ls', 'html', 'cssls', 'tailwindcss',
    'jsonls', 'lemminx', 'yamlls', 'taplo',
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

local cmp = require('cmp')
cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'c_sharp', 'python', 'go', 'gomod', 'gowork', 'gosum',
    'javascript', 'typescript', 'lua', 'html', 'css',
    'json', 'xml', 'yaml', 'toml',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  auto_install = true,
}
