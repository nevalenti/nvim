require("mini.cursorword").setup {}

local function blend(hex_a, hex_b, ratio)
  local a_r, a_g, a_b = tonumber(hex_a:sub(2, 3), 16), tonumber(hex_a:sub(4, 5), 16), tonumber(hex_a:sub(6, 7), 16)
  local b_r, b_g, b_b = tonumber(hex_b:sub(2, 3), 16), tonumber(hex_b:sub(4, 5), 16), tonumber(hex_b:sub(6, 7), 16)
  return ("#%02x%02x%02x"):format(a_r + (b_r - a_r) * ratio, a_g + (b_g - a_g) * ratio, a_b + (b_b - a_b) * ratio)
end

local c = require("cyberdream.colors").default
vim.api.nvim_set_hl(0, "MiniCursorword", { bg = blend(c.bg, c.bg_highlight, 0.5), underline = false })
vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { bg = "NONE", underline = false })
