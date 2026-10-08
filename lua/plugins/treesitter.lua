require("nvim-treesitter").setup {}

local parsers = {
  "javascript",
  "typescript",
  "python",
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
  "markdown",
  "markdown_inline",
  "sql",
  "prisma",
  "regex",
  "gitignore",
  "c_sharp",
  "java",
  "php",
  "php_only",
  "blade",
}

local function start_treesitter(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  local filetype = vim.bo[bufnr].filetype
  local lang = vim.treesitter.language.get_lang(filetype) or filetype
  local ok, available = pcall(vim.treesitter.language.add, lang)
  if not ok or not available then
    return false
  end

  local started = pcall(vim.treesitter.start, bufnr, lang)
  if started then
    vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
  return started
end

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    start_treesitter(args.buf)
  end,
})

local install = require("nvim-treesitter").install(parsers)
install:await(function()
  vim.schedule(function()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].filetype ~= "" then
        start_treesitter(bufnr)
      end
    end
  end)
end)
