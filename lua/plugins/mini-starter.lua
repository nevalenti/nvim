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

local function keymap_item(lhs, label, section)
  return function()
    local map = vim.fn.maparg(lhs, "n", false, true)
    if not map.lhs then
      return {}
    end
    return {
      name = ("%s  %-18s %s"):format(ICONS[lhs] or " ", label, lhs:gsub("<leader>", "Space ")),
      section = section,
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
  silent = true,
  header = function()
    local project = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    return ("\u{E62B}  Neovim\n\n%s  ·  %s"):format(greeting(), project)
  end,
  footer = "Type to filter  ·  Enter to open  ·  Esc to clear",
  items = {
    keymap_item("<leader>ff", "Find a file", "Explore"),
    keymap_item("<leader>fa", "Search project", "Explore"),
    keymap_item("<leader>e", "Browse files", "Explore"),
    keymap_item("<leader>fgs", "Git changes", "Workspace"),
    keymap_item("<leader>ss", "Restore session", "Workspace"),
    keymap_item("<leader>Q", "Quit", "Workspace"),
  },
  content_hooks = {
    starter.gen_hook.adding_bullet "  ",
    starter.gen_hook.aligning("center", "center"),
  },
}

local c = require "theme-palette"
vim.api.nvim_set_hl(0, "MiniStarterHeader", { fg = c.fg, bold = true })
vim.api.nvim_set_hl(0, "MiniStarterSection", { fg = c.fg_dark, bold = true })
vim.api.nvim_set_hl(0, "MiniStarterCurrent", { fg = c.identifier, bg = c.bg_float, bold = true })
vim.api.nvim_set_hl(0, "MiniStarterItem", { fg = c.fg })
vim.api.nvim_set_hl(0, "MiniStarterItemPrefix", { fg = c.accent })
vim.api.nvim_set_hl(0, "MiniStarterQuery", { fg = c.green })
vim.api.nvim_set_hl(0, "MiniStarterFooter", { fg = c.fg_dark })
