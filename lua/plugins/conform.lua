local util = require "conform.util"

require("conform").setup {
  formatters = {
    dotnet_format = {
      command = "dotnet",
      args = function(_, ctx)
        local relative_path = vim.fs.relpath(ctx.cwd, ctx.filename) or ctx.filename
        return { "format", "--include", relative_path, "--no-restore" }
      end,
      stdin = false,
      cwd = util.root_file { "*.sln", "*.csproj", ".git" },
      require_cwd = true,
    },
  },
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports", "gofmt" },
    python = { "ruff_organize_imports", "ruff_format" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    cs = { "dotnet_format" },
    java = { "google-java-format" },
    php = { "php_cs_fixer" },
  },
  format_on_save = {
    timeout_ms = 5000,
    lsp_fallback = true,
  },
}

vim.keymap.set({ "n", "v" }, "<leader>fm", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "Format buffer" })
