require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local servers = {
  "bashls",
  "rust_analyzer",
  "csharp_ls",
  "pyright",
  "ts_ls",
  "html",
  "cssls",
  "jsonls",
  "yamlls",
  "lemminx",
  "angularls",
  "dockerls",
  "terraformls",
  "tailwindcss"
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end
