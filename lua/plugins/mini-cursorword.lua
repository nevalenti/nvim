require("mini.cursorword").setup {}

local c = require "theme-palette"
vim.api.nvim_set_hl(0, "MiniCursorword", { bg = c.hover_bg, underline = false })
vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { bg = "NONE", underline = false })
