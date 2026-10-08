local navic = require "nvim-navic"

navic.setup {
  highlight = true,
  separator = "  ›  ",
  depth_limit = 3,
}

local c = require "theme-palette"

vim.api.nvim_set_hl(0, "NavicText", { fg = c.fg_dark, bg = c.bg })
vim.api.nvim_set_hl(0, "NavicSeparator", { fg = c.border, bg = c.bg })

local kind_colors = {
  File = c.blue,
  Module = c.module,
  Namespace = c.module,
  Package = c.module,
  Class = c.type,
  Method = c.func,
  Property = c.member,
  Field = c.member,
  Constructor = c.type,
  Enum = c.type,
  Interface = c.type,
  Function = c.func,
  Variable = c.identifier,
  Constant = c.constant,
  String = c.string,
  Number = c.number,
  Boolean = c.boolean,
  Array = c.fg,
  Object = c.fg,
  Key = c.fg,
  Null = c.fg,
  EnumMember = c.constant,
  Struct = c.type,
  Event = c.fg,
  Operator = c.operator,
  TypeParameter = c.type,
}
for kind, color in pairs(kind_colors) do
  vim.api.nvim_set_hl(0, "NavicIcons" .. kind, { fg = color, bg = c.bg })
end

local excluded_filetypes = {
  help = true,
  trouble = true,
  lazy = true,
  mason = true,
  notify = true,
  oil = true,
  qf = true,
  checkhealth = true,
  starter = true,
  ministarter = true,
  TelescopePrompt = true,
  ["neo-tree"] = true,
}

local M = {}

function M.winbar()
  if excluded_filetypes[vim.bo.filetype] or vim.bo.buftype ~= "" then
    return ""
  end

  local filename = vim.fn.expand "%:t"
  if filename == "" then
    return ""
  end

  local icon = require("mini.icons").get("file", filename)
  filename = filename:gsub("%%", "%%%%")
  local pill = (" %%#WinBarIslandEdge#%%#WinBarIslandIcon#%s  %%#WinBarIsland#%s"):format(icon, filename)
  if vim.bo.modified then
    pill = pill .. "%#WinBarModified# ●"
  end
  pill = pill .. "%#WinBarIsland# %#WinBarIslandEdge#"

  if vim.api.nvim_win_get_width(0) >= 100 and navic.is_available() then
    local location = navic.get_location()
    if location ~= "" then
      pill = pill .. "%#WinBarIslandSep#  ›  " .. location
    end
  end

  return pill .. "%*"
end

vim.o.winbar = "%{%v:lua.require('plugins.navic').winbar()%}"

return M
