require("mini.cursorword").setup {}

local c = require("vscode.colors").get_colors()
vim.api.nvim_set_hl(0, "MiniCursorword", { bg = c.vscDimHighlight, underline = false })
vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { bg = "NONE", underline = false })
