local util = require "tokyonight.util"

local function from_dracula()
  local p = require "dracula.palette"
  local colors = {
    bg = p.bg,
    bg_float = p.menu,
    bg_statusline = p.menu,
    fg = p.fg,
    fg_dark = p.comment,
    hover_bg = p.selection,
    hover_fg = p.fg,
    caret = p.purple,
    accent = p.purple,
    blue = p.purple,
    green = p.green,
    orange = p.orange,
    purple = p.purple,
    red = p.red,
    gray = p.comment,
    identifier = p.fg,
    type = p.cyan,
    func = p.green,
    parameter = p.orange,
    member = p.fg,
    module = p.pink,
    punctuation = p.fg,
    indent_guide = p.selection,
    constant = p.purple,
    boolean = p.purple,
    operator = p.pink,
    string = p.yellow,
    number = p.purple,
    comment = p.comment,
    selection = p.selection,
    line_number = p.comment,
    border = p.selection,
    popup_selection = p.selection,
    search_bg = p.orange,
    search_fg = p.bg,
    warning = p.orange,
    info = p.cyan,
    hint = p.green,
    current_line_number = p.fg,
    git_add = p.green,
    git_change = p.orange,
  }
  colors.error_bg = util.blend_bg(p.red, 0.1, p.bg)
  colors.warning_bg = util.blend_bg(p.orange, 0.1, p.bg)
  colors.info_bg = util.blend_bg(p.cyan, 0.1, p.bg)
  colors.terminal = {
    p.menu, p.red, p.green, p.yellow, p.purple, p.pink, p.cyan, p.fg,
    p.comment, p.bright_red, p.bright_green, p.bright_yellow,
    p.bright_blue, p.bright_magenta, p.bright_cyan, p.bright_white,
  }
  return colors
end

local function from_tokyodark()
  local c = require "tokyodark.palette"

  local colors = {
    bg = c.bg,
    bg_float = c.bg_float,
    bg_statusline = c.bg_statusline,
    fg = c.fg,
    fg_dark = c.fg_dark,
    hover_bg = c.hover_bg,
    hover_fg = c.hover_fg,
    caret = c.caret,
    accent = c.accent,
    blue = c.blue,
    green = c.green,
    orange = c.orange,
    purple = c.purple,
    red = c.red,
    gray = c.gray,
    identifier = c.orange,
    type = c.type,
    func = c.green,
    parameter = c.orange,
    member = c.orange,
    module = c.red,
    punctuation = c.fg,
    indent_guide = c.indent_guide,
    constant = c.constant,
    boolean = c.purple,
    operator = c.red,
    string = c.string,
    number = c.number,
    comment = c.comment,
    selection = c.bg_visual,
    line_number = c.dim,
    border = c.border,
    popup_selection = c.sel_bg,
    search_bg = c.bg_search,
    search_fg = c.bg,
    warning = c.amber,
    info = c.blue,
    hint = c.cyan,
    current_line_number = c.dim_active,
    git_add = c.green,
    git_change = c.blue,
  }

  colors.error_bg = util.blend_bg(c.red, 0.1, c.bg)
  colors.warning_bg = util.blend_bg(c.amber, 0.1, c.bg)
  colors.info_bg = util.blend_bg(c.blue, 0.1, c.bg)

  colors.terminal = {
    c.bg_dark,
    c.red,
    c.green,
    c.amber,
    c.blue,
    c.purple,
    c.cyan,
    c.fg,
    c.bg_statusline,
    c.red,
    c.green,
    c.amber,
    c.blue,
    c.purple,
    c.cyan,
    c.fg,
  }

  return colors
end

local function from_monokai_classic()
  local c = require "monokai-classic.palette"

  local colors = {
    bg = c.bg,
    bg_float = c.bg_float,
    bg_statusline = c.bg_statusline,
    fg = c.fg,
    fg_dark = c.fg_dark,
    hover_bg = c.hover_bg,
    hover_fg = c.hover_fg,
    caret = c.caret,
    accent = c.accent,
    blue = c.blue,
    green = c.green,
    orange = c.orange,
    purple = c.purple,
    red = c.red,
    gray = c.gray,
    identifier = c.fg,
    type = c.type,
    func = c.green,
    parameter = c.orange,
    member = c.fg,
    module = c.cyan,
    punctuation = c.fg,
    indent_guide = c.indent_guide,
    constant = c.constant,
    boolean = c.purple,
    operator = c.red,
    string = c.string,
    number = c.number,
    comment = c.comment,
    selection = c.bg_visual,
    line_number = c.dim,
    border = c.border,
    popup_selection = c.sel_bg,
    search_bg = c.bg_search,
    warning = c.amber,
    info = c.cyan,
    hint = c.green,
    current_line_number = c.dim_active,
    git_add = c.green,
    git_change = c.orange,
  }

  colors.error_bg = util.blend_bg(c.red, 0.1, c.bg)
  colors.warning_bg = util.blend_bg(c.amber, 0.1, c.bg)
  colors.info_bg = util.blend_bg(c.cyan, 0.1, c.bg)

  colors.terminal = {
    "#1D1E19",
    c.red,
    c.green,
    c.amber,
    c.purple,
    c.red,
    c.cyan,
    "#FDFFF1",
    "#57584F",
    c.red,
    c.green,
    c.amber,
    c.purple,
    c.red,
    c.cyan,
    c.caret,
  }

  return colors
end

local function from_monokai_modern()
  local c = require "monokai-modern.palette"

  local colors = {
    bg = c.bg,
    bg_float = c.bg_float,
    bg_statusline = c.bg_statusline,
    fg = c.fg,
    fg_dark = c.fg_dark,
    hover_bg = c.hover_bg,
    hover_fg = c.hover_fg,
    caret = c.caret,
    accent = c.accent,
    blue = c.blue,
    green = c.green,
    orange = c.orange,
    purple = c.purple,
    red = c.red,
    gray = c.gray,
    identifier = c.fg,
    type = c.type,
    func = c.green,
    parameter = c.orange,
    member = c.fg,
    module = c.cyan,
    punctuation = c.fg,
    indent_guide = c.indent_guide,
    constant = c.constant,
    boolean = c.purple,
    operator = c.red,
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
    git_change = c.orange,
  }

  colors.error_bg = util.blend_bg(c.red, 0.1, c.bg)
  colors.warning_bg = util.blend_bg(c.amber, 0.1, c.bg)
  colors.info_bg = util.blend_bg(c.cyan, 0.1, c.bg)

  colors.terminal = {
    c.bg_dark,
    c.red,
    c.green,
    c.amber,
    c.purple,
    c.red,
    c.cyan,
    c.fg,
    c.dim,
    c.red,
    c.green,
    c.amber,
    c.purple,
    c.red,
    c.cyan,
    c.caret,
  }

  return colors
end

local function from_github_dark()
  local c = require "github-dark.palette"

  local colors = {
    bg = c.bg,
    bg_float = c.bg_float,
    bg_statusline = c.bg_statusline,
    fg = c.fg,
    fg_dark = c.fg_dark,
    hover_bg = c.hover_bg,
    hover_fg = c.hover_fg,
    caret = c.caret,
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
    parameter = c.fg,
    member = c.property,
    module = c.type,
    punctuation = c.fg,
    indent_guide = c.indent_guide,
    constant = c.constant,
    boolean = c.constant,
    operator = c.keyword,
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
    info = c.blue,
    hint = c.gray,
    current_line_number = c.dim_active,
    git_add = c.green,
    git_change = c.amber,
  }

  colors.error_bg = util.blend_bg(c.red, 0.1, c.bg)
  colors.warning_bg = util.blend_bg(c.amber, 0.1, c.bg)
  colors.info_bg = util.blend_bg(c.blue, 0.1, c.bg)

  colors.terminal = c.terminal

  return colors
end

local function from_rose_pine()
  local p = require "rose-pine.palette"

  local colors = {
    bg = p.base,
    bg_float = p.surface,
    bg_statusline = p.surface,
    fg = p.text,
    fg_dark = p.subtle,
    hover_bg = p.highlight_low,
    hover_fg = p.text,
    caret = p.text,
    accent = p.rose,
    blue = p.pine,
    green = p.foam,
    orange = p.gold,
    purple = p.iris,
    red = p.love,
    gray = p.muted,
    identifier = p.text,
    type = p.foam,
    func = p.rose,
    parameter = p.iris,
    member = p.foam,
    module = p.text,
    punctuation = p.subtle,
    indent_guide = p.overlay,
    constant = p.gold,
    boolean = p.rose,
    operator = p.subtle,
    string = p.gold,
    number = p.gold,
    comment = p.muted,
    selection = p.highlight_med,
    line_number = p.muted,
    border = p.highlight_med,
    popup_selection = p.overlay,
    search_bg = p.highlight_med,
    search_fg = p.text,
    warning = p.gold,
    info = p.foam,
    hint = p.iris,
    current_line_number = p.text,
    git_add = p.foam,
    git_change = p.rose,
  }

  colors.error_bg = util.blend_bg(p.love, 0.1, p.base)
  colors.warning_bg = util.blend_bg(p.gold, 0.1, p.base)
  colors.info_bg = util.blend_bg(p.foam, 0.1, p.base)

  colors.terminal = {
    p.overlay,
    p.love,
    p.pine,
    p.gold,
    p.foam,
    p.iris,
    p.rose,
    p.text,
    p.muted,
    p.love,
    p.pine,
    p.gold,
    p.foam,
    p.iris,
    p.rose,
    p.text,
  }

  return colors
end

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

local function from_night_owl()
  local n = require "night-owl.palette"

  local colors = {
    bg = n.bg,
    bg_float = n.blue2,
    bg_statusline = n.tab_active_bg,
    fg = n.fg,
    fg_dark = n.gray6,
    hover_bg = n.blue3,
    hover_fg = n.fg,
    caret = n.cursor_bg,
    accent = n.blue,
    blue = n.blue,
    green = n.green,
    orange = n.orange,
    purple = n.magenta,
    red = n.light_red,
    gray = n.dark_cyan,
    identifier = n.fg,
    type = n.light_orange,
    func = n.blue,
    parameter = n.parameter,
    member = n.light_cyan,
    module = n.light_orange,
    punctuation = n.magenta,
    indent_guide = n.indent_guide,
    constant = n.cyan2,
    boolean = n.light_red,
    operator = n.magenta,
    string = n.light_orange,
    number = n.orange,
    comment = n.dark_cyan,
    selection = n.visual,
    line_number = n.line_number_fg,
    border = n.ui_border2,
    popup_selection = n.blue5,
    search_bg = n.search_blue,
    warning = n.yellow4,
    info = n.blue,
    hint = n.cyan2,
    current_line_number = n.line_number_active_fg,
    git_add = n.sign_add,
    git_change = n.sign_change,
  }

  colors.error_bg = util.blend_bg(n.error_red, 0.1, n.bg)
  colors.warning_bg = util.blend_bg(n.yellow4, 0.1, n.bg)
  colors.info_bg = util.blend_bg(n.blue, 0.1, n.bg)

  -- Night Owl's own integrated-terminal colors.
  colors.terminal = {
    n.dark,
    n.error_red,
    "#22da6e",
    n.green,
    n.blue,
    n.magenta,
    "#21c7a8",
    n.white,
    "#575656",
    n.error_red,
    "#22da6e",
    n.yellow4,
    n.blue,
    n.magenta,
    n.cyan2,
    n.white,
  }

  return colors
end

local function from_gruber(g)

  local colors = {
    bg = g.bg,
    bg_float = g["bg-1"],
    bg_statusline = g["bg+1"],
    fg = g.fg,
    fg_dark = g["fg-1"] or g.quartz,
    inlay_hint = g["fg-2"],
    hover_bg = g["bg+1"],
    hover_fg = g.fg,
    caret = g.yellow,
    accent = g.yellow,
    blue = g.purple or g.niagara,
    green = g.neon or g.green,
    orange = g.brown,
    purple = g.wisteria,
    red = g["red+1"],
    gray = g["niagara-1"],
    identifier = g.fg,
    type = g.purple or g.quartz,
    func = g.slate or g.niagara,
    parameter = g.param or g.fg,
    member = g.fg,
    module = g.purple or g.quartz,
    punctuation = g["fg-1"] or g.fg,
    indent_guide = g["bg+1"],
    constant = g.aqua or g.quartz,
    boolean = g.aqua or g.yellow,
    operator = g.rose or g.fg,
    string = g.neon or g.green,
    number = g.aqua or g.wisteria,
    comment = g.comment or g.brown,
    selection = g["bg+3"],
    visual = g.visual,
    line_number = g["bg+4"],
    border = g["bg+2"],
    popup_selection = g["bg+2"],
    search_bg = g.search or g["niagara-2"],
    warning = g.yellow,
    info = g.niagara,
    hint = g.quartz,
    current_line_number = g.white,
    current_line_number_bg = g["bg-1"],
    git_add = g.neon or g.green,
    git_change = g.yellow,
  }

  colors.error_bg = util.blend_bg(g.red, 0.1, g.bg)
  colors.warning_bg = util.blend_bg(g.yellow, 0.1, g.bg)
  colors.info_bg = util.blend_bg(g.niagara, 0.1, g.bg)

  -- gruber-darker.nvim's terminal colors, with a readable bright black;
  -- palettes with their own syntax hues map them to green (strings),
  -- magenta (functions) and blue (types).
  colors.terminal = {
    g["bg+1"],
    g.red,
    g.neon or g.green,
    g.yellow,
    g.purple or g.niagara,
    g.rose or g.wisteria,
    g.teal or g.niagara,
    g.fg,
    g["niagara-1"],
    g["red+1"],
    g["neon+1"] or g.green,
    g["yellow+1"] or g.yellow,
    g["purple+1"] or g.niagara,
    g["rose+1"] or g.wisteria,
    g["teal+1"] or g.niagara,
    g["fg+1"],
  }

  return colors
end

local function from_gruber_darker()
  local g = {}
  for name, color in pairs(require "gruber-darker.palette") do
    g[name] = color:to_string()
  end
  return from_gruber(g)
end

local function from_gruber_modern()
  return from_gruber(require("gruber-modern.palette").get())
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

if vim.g.colors_name == "gruber-modern" then
  return from_gruber_modern()
end

if vim.g.colors_name == "gruber-darker" then
  return from_gruber_darker()
end

if vim.g.colors_name == "night-owl" then
  return from_night_owl()
end

if vim.g.colors_name == "dracula" then
  return from_dracula()
end

if vim.g.colors_name == "tokyodark" then
  return from_tokyodark()
end

if vim.g.colors_name == "monokai-classic" then
  return from_monokai_classic()
end

if vim.g.colors_name == "monokai-modern" then
  return from_monokai_modern()
end

if vim.g.colors_name:match "^rose%-pine" then
  return from_rose_pine()
end

if vim.g.colors_name == "github-dark" then
  return from_github_dark()
end

if vim.g.colors_name == "gerry-dark" then
  return from_gerry_dark()
end

if vim.g.colors_name == "vscode-modern-dark" then
  return from_vscode_modern_dark()
end

return from_tokyonight()
