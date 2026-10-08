local map = vim.keymap.set
local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr, remap = false }
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
    map("n", "<leader>d", vim.diagnostic.open_float, opts)
    map("n", "]d", function()
      vim.diagnostic.jump { count = 1, float = true }
    end, opts)
    map("n", "[d", function()
      vim.diagnostic.jump { count = -1, float = true }
    end, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("n", "<leader>rr", vim.lsp.buf.references, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("i", "<C-h>", vim.lsp.buf.signature_help, opts)

    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if vim.bo[bufnr].filetype == "cs" and client.name == "roslyn" then
      if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end

      map("n", "<leader>co", function()
        vim.lsp.buf.code_action {
          context = { only = { "source.organizeImports" }, diagnostics = {} },
          apply = true,
        }
      end, vim.tbl_extend("force", opts, { desc = "C#: Organize imports" }))

      map("n", "<leader>cf", function()
        vim.lsp.buf.code_action {
          context = { only = { "source.fixAll" }, diagnostics = {} },
          apply = true,
        }
      end, vim.tbl_extend("force", opts, { desc = "C#: Fix all" }))
    end

    if client.name == "ruff" then
      client.server_capabilities.hoverProvider = false

      client.server_capabilities.diagnosticProvider = nil
    end

    if
      (vim.bo[bufnr].filetype ~= "python" or client.name == "ty")
      and client:supports_method("textDocument/documentSymbol", bufnr)
    then
      require("nvim-navic").attach(client, bufnr)
    end
  end,
})

vim.lsp.config("*", { capabilities = capabilities })

local vue_plugin_path = vim.fn.stdpath "data" .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

vim.lsp.config("ts_ls", {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vue_plugin_path,
        languages = { "vue" },
      },
    },
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

require("mason").setup {}

require("mason-lspconfig").setup {
  ensure_installed = {
    "html",
    "cssls",
    "tailwindcss",
    "ts_ls",
    "vue_ls",
    "eslint",
    "emmet_ls",
    "jsonls",
    "yamlls",
    "taplo",
    "lemminx",
    "lua_ls",
    "jdtls",
    "intelephense",
    "ruff",
    "ty",
    "gopls",
    "rust_analyzer",
  },
  automatic_enable = { exclude = { "jdtls", "csharp_ls", "pyright" } },
}

local mason_registry = require "mason-registry"
mason_registry.refresh(function()
  for _, tool in ipairs {
    "java-debug-adapter",
    "java-test",
    "php-debug-adapter",
    "google-java-format",
    "php-cs-fixer",
    "phpstan",
    "debugpy",
    "netcoredbg",
    "roslyn-language-server",
    "goimports",
    "prettier",
    "stylua",
    "csharpier",
  } do
    local ok, pkg = pcall(mason_registry.get_package, tool)
    if ok and not pkg:is_installed() then
      pkg:install()
    end
  end
end)

require("blink.cmp").setup {
  keymap = {
    preset = "default",
    ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
  },

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },

  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    providers = {
      lsp = {
        name = "LSP",
        module = "blink.cmp.sources.lsp",
        score_offset = 90,
      },
      path = {
        name = "Path",
        module = "blink.cmp.sources.path",
        score_offset = 3,
        opts = {
          trailing_slash = false,
          label_trailing_slash = true,
          get_cwd = function(context)
            return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
          end,
          show_hidden_files_by_default = true,
        },
      },
      snippets = {
        name = "Snippets",
        module = "blink.cmp.sources.snippets",
        score_offset = 80,
        opts = {
          friendly_snippets = true,
          search_paths = { vim.fn.stdpath "config" .. "/snippets" },
          global_snippets = { "all" },
          extended_filetypes = {},
          ignored_filetypes = {},
        },
      },
      buffer = {
        name = "Buffer",
        module = "blink.cmp.sources.buffer",
        score_offset = -3,
      },
    },
  },

  completion = {
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },

    menu = {
      border = "rounded",
      winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
      draw = {
        padding = 1,
        gap = 2,
        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
      },
    },

    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
      update_delay_ms = 50,
      treesitter_highlighting = true,
      window = {
        min_width = 10,
        max_width = 60,
        max_height = 20,
        border = "rounded",
        winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
      },
    },

    ghost_text = {
      enabled = true,
    },
    trigger = {
      prefetch_on_insert = false,
    },
  },

  signature = {
    enabled = true,
    window = {
      border = "rounded",
      winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
    },
  },
}
