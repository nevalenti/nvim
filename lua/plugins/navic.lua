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
  File = c.vscBlue,
  Module = c.vscBlue,
  Namespace = c.vscBlue,
  Package = c.vscBlue,
  Class = c.vscBlue,
  Method = c.vscYellow,
  Property = c.vscBlue,
  Field = c.vscBlue,
  Constructor = c.vscBlue,
  Enum = c.vscBlue,
  Interface = c.vscBlue,
  Function = c.vscYellow,
  Variable = c.vscBlue,
  Constant = c.vscPink,
  String = c.vscOrange,
  Number = c.vscLightGreen,
  Boolean = c.vscLightGreen,
  Array = c.vscFront,
  Object = c.vscFront,
  Key = c.vscFront,
  Null = c.vscFront,
  EnumMember = c.vscPink,
  Struct = c.vscBlue,
  Event = c.vscFront,
  Operator = c.vscBlue,
  TypeParameter = c.vscBlue,
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
