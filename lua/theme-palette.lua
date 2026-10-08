local util = require "tokyonight.util"

local function from_gerry_dark()
  local g = require "gerry-dark.palette"

  local colors = {
    bg = g.bg,
    bg_float = g.bg_float,
    bg_statusline = g.bg_statusline,
    fg = g.fg,
    fg_dark = g.fg_dark,
    hover_bg = g.hover_bg,
    hover_fg = g.hover_fg,
    caret = g.caret,
    accent = g.accent,
    blue = g.blue,
    green = g.green,
    orange = g.orange,
    purple = g.purple,
    red = g.red,
    gray = g.gray,
    identifier = g.fg,
    type = g.salmon,
    func = g.orange,
    parameter = g.blue,
    member = g.salmon,
    module = g.green,
    punctuation = g.fg,
    indent_guide = g.indent_guide,
    constant = g.green,
    boolean = g.green,
    operator = g.purple,
    string = g.green,
    number = g.cyan,
    comment = g.comment,
    selection = g.bg_visual,
    line_number = g.dim,
    border = g.border,
    popup_selection = g.sel_bg,
    search_bg = g.bg_search,
    warning = g.amber,
    info = g.blue,
    hint = g.green,
    current_line_number = g.blue,
    git_add = g.green,
    git_change = g.blue,
  }

  colors.error_bg = util.blend_bg(g.red, 0.1, g.bg)
  colors.warning_bg = util.blend_bg(g.amber, 0.1, g.bg)
  colors.info_bg = util.blend_bg(g.blue, 0.1, g.bg)

  colors.terminal = {
    g.bg_dark,
    g.red,
    g.green,
    g.amber,
    g.blue,
    g.purple,
    g.cyan,
    g.fg,
    g.dim,
    g.red,
    g.green,
    g.amber,
    g.accent,
    g.purple,
    g.cyan,
    g.caret,
  }

  return colors
end

local function from_vscode_modern_dark()
  local c = require "vscode-modern-dark.palette"

  local colors = {
    bg = c.bg,
    bg_float = c.bg_float,
    bg_statusline = c.bg_statusline,
    fg = c.fg,
    fg_dark = c.fg_dark,
    hover_bg = c.bg_highlight,
    hover_fg = c.fg,
    caret = "#ffffff",
    accent = c.accent,
    blue = c.blue,
    green = c.green,
    orange = c.orange,
    purple = c.purple,
    red = c.red,
    gray = c.gray,
    identifier = c.fg,
    type = c.type,
    func = c.func,
    parameter = c.variable,
    member = c.variable,
    module = c.type,
    punctuation = c.fg,
    indent_guide = c.indent_guide,
    constant = c.constant,
    boolean = c.blue,
    operator = c.fg,
    string = c.string,
    number = c.number,
    comment = c.comment,
    selection = c.bg_visual,
    line_number = c.dim,
    border = c.border,
    popup_selection = c.sel_bg,
    search_bg = c.bg_search,
    search_fg = c.fg,
    warning = c.amber,
    info = c.cyan,
    hint = c.green,
    current_line_number = c.dim_active,
    git_add = c.green,
    git_change = c.blue,
  }

  colors.error_bg = util.blend_bg(c.red, 0.1, c.bg)
  colors.warning_bg = util.blend_bg(c.amber, 0.1, c.bg)
  colors.info_bg = util.blend_bg(c.cyan, 0.1, c.bg)

  colors.terminal = {
    c.bg_dark,
    c.red,
    c.green,
    c.amber,
    c.blue,
    c.purple,
    c.cyan,
    c.fg,
    c.gray,
    c.red,
    c.green,
    c.amber,
    c.accent,
    c.purple,
    c.cyan,
    c.sel_fg,
  }

  return colors
end

local function from_tokyonight()
  local p = require("tokyonight.colors").setup()

  local colors = {
    bg = p.bg,
    bg_float = p.bg_float,
    bg_statusline = p.bg_statusline,
    fg = p.fg,
    fg_dark = p.fg_dark,
    hover_bg = p.bg_highlight,
    hover_fg = p.fg,
    caret = "#ffffff",
    accent = p.blue,
    blue = p.blue,
    green = p.green,
    orange = p.orange,
    purple = p.magenta,
    red = p.red,
    gray = p.fg_dark,
    identifier = p.fg,
    type = p.blue1,
    func = p.blue,
    parameter = p.yellow,
    member = p.green1,
    module = p.cyan,
    punctuation = p.blue5,
    indent_guide = p.fg_gutter,
    constant = p.purple,
    boolean = p.magenta2,
    operator = p.blue5,
    string = p.green,
    number = p.orange,
    comment = p.comment,
    selection = p.bg_visual,
    line_number = p.fg_gutter,
    border = p.border_highlight,
    popup_selection = p.bg_highlight,
    search_bg = p.bg_search,
    error_bg = util.blend_bg(p.error, 0.1),
    warning_bg = util.blend_bg(p.warning, 0.1),
    info_bg = util.blend_bg(p.info, 0.1),
    warning = p.warning,
    info = p.info,
    hint = p.hint,
    current_line_number = "#ffffff",
    git_add = p.git.add,
    git_change = p.git.change,
  }

  colors.terminal = {
    p.terminal.black,
    p.terminal.red,
    p.terminal.green,
    p.terminal.yellow,
    p.terminal.blue,
    p.terminal.magenta,
    p.terminal.cyan,
    p.terminal.white,
    p.terminal.black_bright,
    p.terminal.red_bright,
    p.terminal.green_bright,
    p.terminal.yellow_bright,
    p.terminal.blue_bright,
    p.terminal.magenta_bright,
    p.terminal.cyan_bright,
    p.terminal.white_bright,
  }

  return colors
end

if vim.g.colors_name == "gerry-dark" then
  return from_gerry_dark()
end

if vim.g.colors_name == "vscode-modern-dark" then
  return from_vscode_modern_dark()
end

return from_tokyonight()
