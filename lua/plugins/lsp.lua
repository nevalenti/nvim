local map = vim.keymap.set
local capabilities = require("blink.cmp").get_lsp_capabilities()

local function on_attach(_, bufnr)
  local opts = { buffer = bufnr, remap = false }
  map("n", "gd", vim.lsp.buf.definition, opts)
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
end

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
  },
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end,
    lua_ls = function()
      require("lspconfig").lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }
    end,
  },
}

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
        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
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

require("nvim-treesitter").setup {
  ensure_installed = {
    "javascript",
    "typescript",
    "lua",
    "bash",
    "dockerfile",
    "html",
    "css",
    "json",
    "xml",
    "yaml",
    "toml",
    "tsx",
    "vue",
    "tailwindcss",
    "markdown",
    "markdown_inline",
    "sql",
    "prisma",
    "regex",
    "gitignore",
    "dotenv",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  auto_install = true,
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "gnn",
      scope_incremental = false,
      node_decremental = "gnp",
    },
  },
}
