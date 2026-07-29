local navic = require "nvim-navic"

navic.setup {
  highlight = true,
  separator = "  ›  ",
  depth_limit = 6,
}

local c = require("vscode.colors").get_colors()
vim.api.nvim_set_hl(0, "NavicText", { fg = c.vscFront })
vim.api.nvim_set_hl(0, "NavicSeparator", { fg = c.vscGray })

local kind_colors = {
  File = c.vscLightBlue,
  Module = c.vscBlueGreen,
  Namespace = c.vscBlueGreen,
  Package = c.vscBlueGreen,
  Class = c.vscBlueGreen,
  Method = c.vscYellow,
  Property = c.vscLightBlue,
  Field = c.vscLightBlue,
  Constructor = c.vscBlueGreen,
  Enum = c.vscBlueGreen,
  Interface = c.vscBlueGreen,
  Function = c.vscYellow,
  Variable = c.vscLightBlue,
  Constant = c.vscAccentBlue,
  String = c.vscOrange,
  Number = c.vscLightGreen,
  Boolean = c.vscLightGreen,
  Array = c.vscFront,
  Object = c.vscFront,
  Key = c.vscFront,
  Null = c.vscFront,
  EnumMember = c.vscAccentBlue,
  Struct = c.vscBlueGreen,
  Event = c.vscFront,
  Operator = c.vscBlue,
  TypeParameter = c.vscBlueGreen,
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
