local lsp = require "lsp-zero"
local map = vim.keymap.set

lsp.extend_lspconfig {
  sign_icons = true,
  lsp_attach = function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }
    map("n", "gd", function()
      vim.lsp.buf.definition()
    end, opts)
    map("n", "K", function()
      vim.lsp.buf.hover()
    end, opts)
    map("n", "<leader>ws", function()
      vim.lsp.buf.workspace_symbol()
    end, opts)
    map("n", "<leader>d", function()
      vim.diagnostic.open_float()
    end, opts)
    map("n", "]d", function()
      vim.diagnostic.jump { count = 1, float = true }
    end, opts)
    map("n", "[d", function()
      vim.diagnostic.jump { count = -1, float = true }
    end, opts)
    map("n", "<leader>ca", function()
      vim.lsp.buf.code_action()
    end, opts)
    map("n", "<leader>rr", function()
      vim.lsp.buf.references()
    end, opts)
    map("n", "<leader>rn", function()
      vim.lsp.buf.rename()
    end, opts)
    map("i", "<C-h>", function()
      vim.lsp.buf.signature_help()
    end, opts)
  end,
  capabilities = require("blink.cmp").get_lsp_capabilities(),
}

require("mason").setup {}

require("mason-lspconfig").setup {
  ensure_installed = {
    "csharp_ls",
    "gopls",
    "pyright",
    "ruff",
    "ts_ls",
    "lua_ls",
    "html",
    "cssls",
    "tailwindcss",
    "jsonls",
    "lemminx",
    "yamlls",
    "taplo",
  },
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup {}
    end,
    lua_ls = function()
      local lua_opts = lsp.nvim_lua_ls()
      lua_opts.settings = lua_opts.settings or {}
      lua_opts.settings.Lua = lua_opts.settings.Lua or {}
      lua_opts.settings.Lua.diagnostics = lua_opts.settings.Lua.diagnostics or {}
      lua_opts.settings.Lua.diagnostics.globals = { "vim" }
      require("lspconfig").lua_ls.setup(lua_opts)
    end,
  },
}

require("blink.cmp").setup {
  keymap = {
    preset = "default",
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<C-y>"] = { "select_and_accept" },

    ["<C-p>"] = { "select_prev", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },

    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },

    ["<Tab>"] = { "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
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
      prefetch_on_insert = true,
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
    "c_sharp",
    "python",
    "go",
    "gomod",
    "gowork",
    "gosum",
    "javascript",
    "typescript",
    "lua",
    "html",
    "css",
    "json",
    "xml",
    "yaml",
    "toml",
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
