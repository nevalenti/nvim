-- lualine theme for Gruber Modern; picked up by `theme = "auto"` or
-- `theme = "gruber-modern"`. Follows 'background' like the colorscheme.
local c = require("gruber-modern.palette").get()
local bar = c["bg+1"]

local function mode(color)
  return {
    a = { fg = c.bg, bg = color, gui = "bold" },
    b = { fg = c.fg, bg = c["bg+2"] },
    c = { fg = c["fg-1"], bg = bar },
  }
end

return {
  normal = mode(c.yellow),
  insert = mode(c.neon),
  visual = mode(c.purple),
  replace = mode(c.red),
  command = mode(c.brown),
  terminal = mode(c.aqua),
  inactive = {
    a = { fg = c["fg-2"], bg = bar },
    b = { fg = c["fg-2"], bg = bar },
    c = { fg = c["fg-2"], bg = bar },
  },
}
