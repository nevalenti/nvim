require("nvim-treesitter").setup {}

require("nvim-treesitter").install {
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
  "markdown",
  "markdown_inline",
  "sql",
  "prisma",
  "regex",
  "gitignore",
  "c_sharp",
}

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match) or args.match
    if not vim.treesitter.language.add(lang) then
      return
    end
    vim.treesitter.start(args.buf, lang)
    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
