-- Gruber Modern: a self-contained colorscheme. `setup()` takes options,
-- `load()` (run by colors/gruber-modern.lua) applies the variant matching
-- 'background', so `:set background=light` switches it live.
local M = {}

local defaults = {
  -- Leave Normal, floats and the gutter unpainted, so the terminal shows.
  transparent = false,
  -- Inactive windows get a darker background and dimmed plain text.
  dim_inactive = true,
  bold = true,
  -- Extra attributes per syntax role, merged over the theme's own, e.g.
  -- `comments = { italic = true }` or `keywords = { bold = false }`.
  styles = {
    comments = {},
    keywords = {},
    strings = {},
    functions = {},
    variables = {},
    types = {},
  },
  -- function(highlights, colors) for last-word tweaks; edit `highlights` in
  -- place.
  on_highlights = nil,
}

M.options = vim.deepcopy(defaults)

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})
end

function M.load()
  if vim.g.colors_name then
    vim.cmd "highlight clear"
  end
  if vim.fn.exists "syntax_on" == 1 then
    vim.cmd "syntax reset"
  end
  vim.o.termguicolors = true
  vim.g.colors_name = "gruber-modern"

  local c = require("gruber-modern.palette").get()
  local highlights = require "gruber-modern.groups"
  local groups = highlights.get(c, M.options)
  if M.options.on_highlights then
    M.options.on_highlights(groups, c)
  end

  local set_hl = vim.api.nvim_set_hl
  for group, spec in pairs(groups) do
    set_hl(0, group, spec)
  end

  for index, color in ipairs(highlights.terminal(c)) do
    vim.g["terminal_color_" .. (index - 1)] = color
  end
end

return M
