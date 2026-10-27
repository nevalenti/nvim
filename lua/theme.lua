vim.o.background = "dark"
vim.o.guifont = "FiraCode Nerd Font:h12"

require("gruber-darker").setup()
vim.cmd.colorscheme "gruber-modern"

local c = require "theme-palette"
local blend_bg = require("tokyonight.util").blend_bg

for index, color in ipairs(c.terminal) do
  vim.g["terminal_color_" .. (index - 1)] = color
end
vim.g.terminal_color_background = c.bg
vim.g.terminal_color_foreground = c.fg

vim.api.nvim_set_hl(0, "Cursor", { fg = c.bg, bg = c.caret })
vim.api.nvim_set_hl(0, "lCursor", { link = "Cursor" })
vim.api.nvim_set_hl(0, "TermCursor", { link = "Cursor" })
vim.opt.guicursor =
  "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor,t:block-blinkon500-blinkoff500-TermCursor"

local ui = {
  NormalFloat = { fg = c.fg, bg = c.bg_float },
  NormalNC = { fg = c.fg_dark, bg = blend_bg("#000000", 0.12, c.bg) },
  CursorLineNC = { bg = c.bg },
  FloatBorder = { fg = c.border, bg = c.bg_float },
  FloatTitle = { fg = c.accent, bg = c.bg_float, bold = true },
  WinSeparator = { fg = c.border, bg = c.bg },
  LineNr = { fg = c.line_number },
  LineNrAbove = { link = "LineNr" },
  LineNrBelow = { link = "LineNr" },
  CursorLineNr = { fg = c.current_line_number, bg = c.hover_bg, bold = true },
  EndOfBuffer = { fg = c.bg },
  NonText = { fg = c.indent_guide },
  Whitespace = { fg = c.indent_guide },
  MatchParen = { fg = c.identifier, bg = c.popup_selection, bold = true },
  Search = { fg = c.search_fg or c.fg, bg = c.search_bg },
  IncSearch = { fg = c.bg, bg = c.accent },
  CurSearch = { link = "IncSearch" },
  Pmenu = { fg = c.fg, bg = c.bg_float },
  PmenuSel = { fg = c.fg, bg = c.popup_selection, bold = true },
  PmenuSbar = { bg = c.bg_float },
  PmenuThumb = { bg = c.border },
  PmenuMatch = { fg = c.purple, bg = c.bg_float, bold = true },
  PmenuMatchSel = { fg = c.accent, bg = c.popup_selection, bold = true },
  StatusLine = { fg = c.fg_dark, bg = c.bg_statusline },
  StatusLineNC = { link = "StatusLine" },
  TabLine = { fg = c.fg_dark, bg = c.bg_statusline },
  TabLineFill = { bg = c.bg_statusline },
  TabLineSel = { fg = c.accent, bg = c.bg_float, bold = true },
  TelescopeNormal = { fg = c.fg, bg = c.bg_float },
  TelescopePromptNormal = { fg = c.fg, bg = c.bg_float },
  TelescopeResultsNormal = { fg = c.fg, bg = c.bg_float },
  TelescopePreviewNormal = { fg = c.fg, bg = c.bg_float },
  TelescopeBorder = { fg = c.border, bg = c.bg_float },
  TelescopePromptBorder = { fg = c.border, bg = c.bg_float },
  TelescopeResultsBorder = { fg = c.border, bg = c.bg_float },
  TelescopePreviewBorder = { fg = c.border, bg = c.bg_float },
  TelescopeTitle = { fg = c.fg_dark, bg = c.bg_float, bold = true },
  TelescopePromptTitle = { fg = c.accent, bg = c.bg_float, bold = true },
  TelescopeResultsTitle = { fg = c.fg_dark, bg = c.bg_float, bold = true },
  TelescopePreviewTitle = { fg = c.fg_dark, bg = c.bg_float, bold = true },
  TelescopePromptPrefix = { fg = c.accent, bg = c.bg_float },
  TelescopePromptCounter = { fg = c.fg_dark, bg = c.bg_float },
  TelescopeMatching = { fg = c.accent, bold = true },
  TelescopeFileIcon = { fg = c.blue },
  TelescopeResultsComment = { fg = c.fg_dark },
  TelescopeSelection = { fg = c.fg, bg = c.popup_selection, bold = true },
  TelescopeSelectionCaret = { fg = c.accent, bg = c.popup_selection, bold = true },
  OilNormalFloat = { link = "NormalFloat" },
  OilFloatBorder = { link = "FloatBorder" },
  OilFooter = { fg = c.fg_dark, bg = c.bg_float },
  OilFileIcon = { fg = c.fg_dark },
  OilHidden = { fg = c.fg_dark },
  OilDirHidden = { fg = c.fg_dark, bold = true },
  OilSignColumn = { bg = c.bg_float },
  OilCursorLine = { link = "CursorLine" },
  NoiceCmdlinePopup = { link = "NormalFloat" },
  NoiceCmdlinePopupBorder = { link = "FloatBorder" },
  NoiceCmdlinePopupTitle = { link = "FloatTitle" },
  NoiceCmdlineIcon = { fg = c.purple },
  NoiceCmdlinePopupBorderSearch = { link = "FloatBorder" },
  NoicePopupmenu = { link = "Pmenu" },
  NoicePopupmenuBorder = { link = "FloatBorder" },
  NoicePopupmenuSelected = { link = "PmenuSel" },
  BlinkCmpMenu = { link = "Pmenu" },
  BlinkCmpMenuBorder = { link = "FloatBorder" },
  BlinkCmpMenuSelection = { link = "PmenuSel" },
  BlinkCmpLabel = { fg = c.fg },
  BlinkCmpLabelMatch = { fg = c.accent, bold = true },
  BlinkCmpLabelDetail = { fg = c.fg_dark },
  BlinkCmpLabelDescription = { fg = c.fg_dark },
  BlinkCmpKind = { fg = c.blue },
  BlinkCmpDoc = { link = "NormalFloat" },
  BlinkCmpDocBorder = { link = "FloatBorder" },
  BlinkCmpDocCursorLine = { bg = c.popup_selection },
  BlinkCmpSignatureHelp = { link = "NormalFloat" },
  BlinkCmpSignatureHelpBorder = { link = "FloatBorder" },
  BlinkCmpGhostText = { fg = c.inlay_hint or c.fg_dark, italic = true },
  WhichKeyNormal = { link = "NormalFloat" },
  WhichKeyBorder = { link = "FloatBorder" },
  WhichKeyTitle = { link = "FloatTitle" },
  WhichKey = { fg = c.accent },
  WhichKeyGroup = { fg = c.purple },
  WhichKeyDesc = { fg = c.fg },
  WhichKeySeparator = { fg = c.border },
  WhichKeyValue = { fg = c.fg_dark },
  DiagnosticVirtualTextError = { fg = c.red, bg = c.error_bg },
  DiagnosticVirtualTextWarn = { fg = c.warning, bg = c.warning_bg },
  DiagnosticVirtualTextInfo = { fg = c.info, bg = c.info_bg },
  DiagnosticVirtualTextHint = { fg = c.hint, bg = c.bg_float },
  ErrorMsg = { fg = c.red },
  WarningMsg = { fg = c.warning },
  GitSignsAdd = { fg = c.git_add },
  GitSignsChange = { fg = c.git_change },
  GitSignsDelete = { fg = c.red },
  LspReferenceText = { bg = c.popup_selection },
  LspReferenceRead = { link = "LspReferenceText" },
  LspReferenceWrite = { link = "LspReferenceText" },
  LspInlayHint = { fg = c.inlay_hint or c.fg_dark, bg = c.bg_float, italic = true },
}
-- rose-pine is used as-is, like ThePrimeagen's setup; the shared overrides
-- would repaint its UI groups with this config's own look.
local stock = vim.g.colors_name:match "^rose%-pine" ~= nil

if not stock then
  for group, highlight in pairs(ui) do
    vim.api.nvim_set_hl(0, group, highlight)
  end

  for severity, color in pairs { Error = c.red, Warn = c.warning, Info = c.info, Hint = c.hint } do
    vim.api.nvim_set_hl(0, "Diagnostic" .. severity, { fg = color })
    vim.api.nvim_set_hl(0, "DiagnosticSign" .. severity, { link = "Diagnostic" .. severity })
    vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. severity, { sp = color, undercurl = true })
  end
else
  -- ColorMyPencils: let the terminal background show through.
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

vim.api.nvim_set_hl(0, "WinBar", { fg = c.fg, bg = c.bg })
vim.api.nvim_set_hl(0, "WinBarNC", { fg = c.gray, bg = c.bg })
vim.api.nvim_set_hl(0, "WinBarIsland", { fg = c.fg, bg = c.bg_float, bold = true })
vim.api.nvim_set_hl(0, "WinBarIslandEdge", { fg = c.bg_float, bg = c.bg })
vim.api.nvim_set_hl(0, "WinBarModified", { fg = c.accent, bg = c.bg_float })
vim.api.nvim_set_hl(0, "WinBarIslandIcon", { fg = c.blue, bg = c.bg_float })
vim.api.nvim_set_hl(0, "WinBarIslandSep", { fg = c.border, bg = c.bg })

vim.api.nvim_set_hl(0, "OilMtime", { fg = c.fg_dark })
vim.api.nvim_set_hl(0, "OilGitAuthor", { fg = c.fg_dark })

vim.api.nvim_set_hl(0, "OilDir", { fg = c.identifier, bold = true })
vim.api.nvim_set_hl(0, "OilDirIcon", { fg = c.fg_dark })
vim.api.nvim_set_hl(0, "OilLink", { fg = c.fg_dark, underline = true })
vim.api.nvim_set_hl(0, "OilCreate", { fg = c.green })
vim.api.nvim_set_hl(0, "OilCopy", { fg = c.green })
vim.api.nvim_set_hl(0, "OilMove", { fg = c.orange })
vim.api.nvim_set_hl(0, "OilChange", { fg = c.orange })
vim.api.nvim_set_hl(0, "OilDelete", { fg = c.red })

vim.api.nvim_set_hl(0, "TelescopeResultsDiffUntracked", { fg = c.gray })

vim.api.nvim_set_hl(0, "diffIndexLine", { fg = c.gray })
vim.api.nvim_set_hl(0, "diffComment", { fg = c.gray })

local function set_yank_highlight()
  vim.api.nvim_set_hl(0, "YankHighlight", { fg = c.bg, bg = c.blue })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("YankHighlightTheme", { clear = true }),
  callback = set_yank_highlight,
})
set_yank_highlight()

-- Waybar, Rofi, swaync and btop take their colors from the palette.
local theme_sync = require "theme-sync"
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("ThemeSync", { clear = true }),
  callback = function()
    package.loaded["theme-palette"] = nil
    local ok, palette = pcall(require, "theme-palette")
    if ok then
      theme_sync.sync(palette)
    end
  end,
})
theme_sync.sync(c)
