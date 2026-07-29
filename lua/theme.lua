vim.o.background = "dark"

require("vscode").setup {
  style = "dark",
  italic_comments = true,
  italic_inlayhints = true,
  underline_links = true,
  terminal_colors = true,
  color_overrides = {
    vscFront = "#CCCCCC",
    vscLeftDark = "#181818",
    vscLineNumber = "#6E7681",
  },
}

vim.cmd.colorscheme "vscode"

for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end

vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })

vim.g.terminal_color_0 = "#000000"
vim.g.terminal_color_1 = "#cd3131"
vim.g.terminal_color_2 = "#0dbc79"
vim.g.terminal_color_3 = "#e5e510"
vim.g.terminal_color_4 = "#2472c8"
vim.g.terminal_color_5 = "#bc3fbc"
vim.g.terminal_color_6 = "#11a8cd"
vim.g.terminal_color_7 = "#e5e5e5"
vim.g.terminal_color_8 = "#666666"
vim.g.terminal_color_9 = "#f14c4c"
vim.g.terminal_color_10 = "#23d18b"
vim.g.terminal_color_11 = "#f5f543"
vim.g.terminal_color_12 = "#3b8eea"
vim.g.terminal_color_13 = "#d670d6"
vim.g.terminal_color_14 = "#29b8db"
vim.g.terminal_color_15 = "#e5e5e5"

local c = require("vscode.colors").get_colors()

vim.api.nvim_set_hl(0, "OilMtime", { fg = c.vscGreen })
vim.api.nvim_set_hl(0, "OilGitAuthor", { fg = c.vscYellow, bold = true })

vim.api.nvim_set_hl(0, "OilDir", { fg = c.vscBlue, bold = true })
vim.api.nvim_set_hl(0, "OilDirIcon", { fg = c.vscBlue, bold = true })
vim.api.nvim_set_hl(0, "OilLink", { fg = c.vscAccentBlue })
vim.api.nvim_set_hl(0, "OilCreate", { fg = c.vscAccentBlue })
vim.api.nvim_set_hl(0, "OilCopy", { fg = c.vscAccentBlue })
vim.api.nvim_set_hl(0, "OilMove", { fg = c.vscYellow })
vim.api.nvim_set_hl(0, "OilChange", { fg = c.vscGitModified })
vim.api.nvim_set_hl(0, "OilDelete", { fg = c.vscRed })

vim.api.nvim_set_hl(0, "TelescopeResultsDiffUntracked", { fg = c.vscGray })

vim.api.nvim_set_hl(0, "diffIndexLine", { fg = c.vscGray })
vim.api.nvim_set_hl(0, "diffComment", { fg = c.vscGray })

vim.api.nvim_set_hl(0, "LineNr", { fg = c.vscFront })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = c.vscBlue, bold = true })

vim.api.nvim_set_hl(0, "YankHighlight", { fg = c.vscBack, bg = c.vscAccentBlue })
