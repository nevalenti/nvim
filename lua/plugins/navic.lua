local navic = require "nvim-navic"

navic.setup {
  highlight = true,
  separator = "  ›  ",
  depth_limit = 6,
}

local c = require("cyberdream.colors").default
vim.api.nvim_set_hl(0, "NavicText", { fg = c.fg })
vim.api.nvim_set_hl(0, "NavicSeparator", { fg = c.grey })

local kind_colors = {
  File = c.blue,
  Module = c.cyan,
  Namespace = c.cyan,
  Package = c.cyan,
  Class = c.cyan,
  Method = c.yellow,
  Property = c.blue,
  Field = c.blue,
  Constructor = c.cyan,
  Enum = c.cyan,
  Interface = c.cyan,
  Function = c.yellow,
  Variable = c.blue,
  Constant = c.purple,
  String = c.orange,
  Number = c.green,
  Boolean = c.green,
  Array = c.fg,
  Object = c.fg,
  Key = c.fg,
  Null = c.fg,
  EnumMember = c.purple,
  Struct = c.cyan,
  Event = c.fg,
  Operator = c.blue,
  TypeParameter = c.cyan,
}
for kind, color in pairs(kind_colors) do
  vim.api.nvim_set_hl(0, "NavicIcons" .. kind, { fg = color })
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

  local icon, hl = require("mini.icons").get("file", filename)
  local winbar = ("%%#%s#%s%%*  %s"):format(hl, icon, filename)

  if navic.is_available() then
    local location = navic.get_location()
    if location ~= "" then
      winbar = winbar .. "  ›  " .. location
    end
  end

  return winbar
end

vim.o.winbar = "%{%v:lua.require('plugins.navic').winbar()%}"

return M
