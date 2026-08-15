vim.o.background = "dark"

require("vscode").setup {
  transparent = false,
  italic_comments = true,
  italic_inlayhints = true,
  underline_links = true,
  disable_nvimtree_bg = true,
  terminal_colors = true,
}

vim.cmd.colorscheme "vscode"

for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end

local c = require("vscode.colors").get_colors()

vim.api.nvim_set_hl(0, "StatusLine", { bg = c.vscLeftDark })
vim.api.nvim_set_hl(0, "WinBar", { fg = c.vscFront, bg = c.vscLeftDark })
vim.api.nvim_set_hl(0, "WinBarNC", { fg = c.vscGray, bg = c.vscLeftDark })

vim.api.nvim_set_hl(0, "OilMtime", { fg = c.vscLightGreen })
vim.api.nvim_set_hl(0, "OilGitAuthor", { fg = c.vscYellow, bold = true })

vim.api.nvim_set_hl(0, "OilDir", { fg = c.vscBlue, bold = true })
vim.api.nvim_set_hl(0, "OilDirIcon", { fg = c.vscBlue, bold = true })
vim.api.nvim_set_hl(0, "OilLink", { fg = c.vscBlue })
vim.api.nvim_set_hl(0, "OilCreate", { fg = c.vscBlue })
vim.api.nvim_set_hl(0, "OilCopy", { fg = c.vscBlue })
vim.api.nvim_set_hl(0, "OilMove", { fg = c.vscYellow })
vim.api.nvim_set_hl(0, "OilChange", { fg = c.vscOrange })
vim.api.nvim_set_hl(0, "OilDelete", { fg = c.vscRed })

vim.api.nvim_set_hl(0, "TelescopeResultsDiffUntracked", { fg = c.vscGray })

vim.api.nvim_set_hl(0, "diffIndexLine", { fg = c.vscGray })
vim.api.nvim_set_hl(0, "diffComment", { fg = c.vscGray })

vim.api.nvim_set_hl(0, "LineNr", { fg = c.vscFront })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = c.vscBlue, bold = true })
vim.api.nvim_set_hl(0, "CursorLine", { bg = c.vscCursorDarkDark })

vim.api.nvim_set_hl(0, "YankHighlight", { fg = c.vscBack, bg = c.vscBlue })
