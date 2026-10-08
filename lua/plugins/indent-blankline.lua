local c = require "theme-palette"

vim.api.nvim_set_hl(0, "IblIndent", { fg = c.indent_guide })
vim.api.nvim_set_hl(0, "IblScope", { fg = c.accent })

require("ibl").setup {
  indent = { char = "│", tab_char = "│", highlight = "IblIndent" },
  whitespace = { highlight = "IblIndent", remove_blankline_trail = false },
  scope = { enabled = false, highlight = "IblScope" },
  exclude = {
    filetypes = {
      "",
      "help",
      "man",
      "checkhealth",
      "gitcommit",
      "lspinfo",
      "trouble",
      "lazy",
      "mason",
      "notify",
      "oil",
      "qf",
      "starter",
      "TelescopePrompt",
      "TelescopeResults",
    },
  },
}
