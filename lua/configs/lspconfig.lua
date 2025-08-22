require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local servers = {
  "bashls",
  "rust_analyzer",
  -- "csharp_ls",
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

lspconfig.omnisharp.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "dotnet", "/usr/lib/omnisharp-roslyn/OmniSharp.dll" },
  -- Or use the default path if installed via Mason:
  -- cmd = { "OmniSharp" },

  -- Enable Roslyn analysers
  enable_roslyn_analyzers = true,
  -- Enable editor config support
  enable_editorconfig_support = true,
  -- Organize imports on format
  organize_imports_on_format = true,
  -- Enable MS Build load projects on demand
  enable_ms_build_load_projects_on_demand = false,
})
