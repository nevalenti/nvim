local starter = require "mini.starter"

local function greeting()
  local hour = tonumber(vim.fn.strftime "%H")
  if hour < 5 then
    return "night owl"
  elseif hour < 12 then
    return "good morning"
  elseif hour < 18 then
    return "good afternoon"
  else
    return "good evening"
  end
end

local ICONS = {
  ["<leader>ff"] = "\u{F002}",
  ["<leader>fa"] = "\u{F002}",
  ["<leader>fgs"] = "\u{F1D3}",
  ["<leader>e"] = "\u{F07C}",
  ["<leader>ss"] = "\u{F1DA}",
  ["<leader>Q"] = "\u{F011}",
}

local function keymap_item(lhs)
  return function()
    local map = vim.fn.maparg(lhs, "n", false, true)
    if not map.lhs then
      return {}
    end
    return {
      name = ("%s  %-11s %s"):format(ICONS[lhs] or " ", lhs, map.desc or lhs),
      section = "Keybindings",
      action = function()
        if map.callback then
          map.callback()
        elseif map.rhs and map.rhs ~= "" then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(map.rhs, true, true, true), "m", false)
        end
      end,
    }
  end
end

starter.setup {
  evaluate_single = true,
  header = function()
    return ("\u{E62B}  NEOVIM\n%s"):format(greeting())
  end,
  footer = "type a number, or <CR> on a line",
  items = {
    keymap_item "<leader>ff",
    keymap_item "<leader>fa",
    keymap_item "<leader>fgs",
    keymap_item "<leader>e",
    keymap_item "<leader>ss",
    keymap_item "<leader>Q",
  },
  content_hooks = {
    starter.gen_hook.indexing("all", {}),
    starter.gen_hook.aligning("center", "center"),
  },
}

local c = require("vscode.colors").get_colors()
vim.api.nvim_set_hl(0, "MiniStarterHeader", { fg = c.vscBlue, bold = true })
vim.api.nvim_set_hl(0, "MiniStarterSection", { fg = c.vscYellow, bold = true })
vim.api.nvim_set_hl(0, "MiniStarterItem", { fg = c.vscFront })
vim.api.nvim_set_hl(0, "MiniStarterItemPrefix", { fg = c.vscAccentBlue })
vim.api.nvim_set_hl(0, "MiniStarterQuery", { fg = c.vscGreen })
vim.api.nvim_set_hl(0, "MiniStarterFooter", { fg = c.vscGray, italic = true })
