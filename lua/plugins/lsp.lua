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

  -- vim.cmd("highlight GreenText guifg=#00FF00")
  -- local lsp_name_str = table.concat(lsp_names, ", ")
  -- vim.api.nvim_echo({
  --   { "LSP " .. lsp_name_str .. " attached to buffer: " .. vim.api.nvim_buf_get_name(bufnr) .. "\n", "GreenText" }
  -- }, true, {})

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

