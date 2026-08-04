vim.o.background = "dark"

require("cyberdream").setup {
  variant = "default",
  italic_comments = true,
  terminal_colors = true,
  extensions = {
    mini = true,
    gitsigns = true,
  },
}

vim.cmd.colorscheme "cyberdream"

for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end

vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })

local c = require("cyberdream.colors").default

vim.api.nvim_set_hl(0, "OilMtime", { fg = c.green })
vim.api.nvim_set_hl(0, "OilGitAuthor", { fg = c.yellow, bold = true })

vim.api.nvim_set_hl(0, "OilDir", { fg = c.blue, bold = true })
vim.api.nvim_set_hl(0, "OilDirIcon", { fg = c.blue, bold = true })
vim.api.nvim_set_hl(0, "OilLink", { fg = c.cyan })
vim.api.nvim_set_hl(0, "OilCreate", { fg = c.cyan })
vim.api.nvim_set_hl(0, "OilCopy", { fg = c.cyan })
vim.api.nvim_set_hl(0, "OilMove", { fg = c.yellow })
vim.api.nvim_set_hl(0, "OilChange", { fg = c.orange })
vim.api.nvim_set_hl(0, "OilDelete", { fg = c.red })

vim.api.nvim_set_hl(0, "TelescopeResultsDiffUntracked", { fg = c.grey })

vim.api.nvim_set_hl(0, "diffIndexLine", { fg = c.grey })
vim.api.nvim_set_hl(0, "diffComment", { fg = c.grey })

vim.api.nvim_set_hl(0, "LineNr", { fg = c.fg })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = c.blue, bold = true })

vim.api.nvim_set_hl(0, "YankHighlight", { fg = c.bg, bg = c.cyan })
