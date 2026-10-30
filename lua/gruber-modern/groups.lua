-- Highlight groups for Gruber Modern, built from a palette variant (see
-- palette.lua) and the options from init.lua. Each section returns a plain
-- table of group -> nvim_set_hl() spec; M.get() merges them and init.lua
-- applies the result.
local blend = require("gruber-modern.util").blend

local M = {}

-- Syntax by role: each color has one job, and loudness follows importance.
--   structure  yellow       keywords; control flow in bold
--   values     neon/aqua    strings in neon; numbers, booleans and named
--                           constants in aqua
--   shapes     purple       types and constructors; declarations in bold
--   behavior   strong/slate function definitions bold, calls slate
--   names      fg/param     variables and members in fg; parameters cream,
--                           so a function's inputs stand out from its locals
--   glue       punct/rose   brackets and separators in a steel blue-gray, tinted
--                           but quieter than the names between them; operators
--                           rose; modules and tag attributes recede to fg-1
--   notes      amber        comments, a muted amber; TODO-style tags get a
--                           label
-- Diagnostics use hues the syntax doesn't: info is niagara blue, hint is
-- quartz. Warn keeps the conventional yellow; it only appears as signs,
-- undercurls and tinted virtual text, never as a bare token.
local function roles(c)
  return {
    keyword = c.yellow,
    string = c.neon,
    literal = c.aqua,
    constant = c.aqua,
    type = c.purple,
    func = c.slate,
    func_def = c.strong,
    name = c.fg,
    param = c.param,
    glue = c["fg-1"],
    punct = c.punct,
    operator = c.rose,
    comment = c.comment,
    special = c.yellow,
    error = c["red+1"],
    warn = c.yellow,
    info = c.niagara,
    hint = c.quartz,
    ok = c.neon,
    add = c.neon,
    change = c.yellow,
    delete = c["red+1"],
  }
end

local function editor(c, r, o)
  local bg = o.transparent and "NONE" or c.bg
  local float = o.transparent and "NONE" or c["bg-1"]
  return {
    Normal = { fg = c.fg, bg = bg },
    NormalNC = o.dim_inactive and { fg = c["fg-1"], bg = c["bg-1"] } or { link = "Normal" },
    NormalSB = { fg = c.fg, bg = float },
    NormalFloat = { fg = c.fg, bg = float },
    FloatBorder = { fg = c["bg+2"], bg = float },
    FloatTitle = { fg = c.yellow, bg = float, bold = o.bold },
    FloatFooter = { fg = c["fg-1"], bg = float },

    Cursor = { fg = c.bg, bg = c.yellow },
    lCursor = { link = "Cursor" },
    CursorIM = { link = "Cursor" },
    TermCursor = { link = "Cursor" },
    CursorLine = { bg = c["bg+1"] },
    CursorColumn = { bg = c["bg+1"] },
    ColorColumn = { bg = c["bg+1"] },
    CursorLineNC = { bg = bg },

    -- The gutter shares the editor background; the cursor line runs through
    -- it as one band.
    LineNr = { fg = c["bg+4"] },
    LineNrAbove = { link = "LineNr" },
    LineNrBelow = { link = "LineNr" },
    CursorLineNr = { fg = c.white, bg = c["bg-1"], bold = o.bold },
    SignColumn = { fg = c["bg+4"], bg = bg },
    CursorLineSign = { bg = c["bg-1"] },
    FoldColumn = { fg = c["bg+4"], bg = bg },
    CursorLineFold = { fg = c["fg-1"], bg = c["bg-1"] },
    Folded = { fg = c["fg-1"], bg = c["bg+1"] },

    Visual = { bg = c.visual },
    VisualNOS = { link = "Visual" },
    Search = { fg = c.fg, bg = c.search },
    IncSearch = { fg = c.bg, bg = c.yellow, bold = o.bold },
    CurSearch = { link = "IncSearch" },
    Substitute = { fg = c.bg, bg = c.red },
    MatchParen = { fg = c.fg, bg = c["bg+2"], bold = o.bold },
    QuickFixLine = { bg = c["bg+2"], bold = o.bold },

    EndOfBuffer = { fg = c.bg },
    NonText = { fg = c["bg+3"] },
    Whitespace = { fg = c["bg+2"] },
    SpecialKey = { fg = c["fg-2"] },
    Conceal = { fg = c["fg-2"] },
    Directory = { fg = c.purple, bold = o.bold },
    Title = { fg = c.yellow, bold = o.bold },

    WinSeparator = { fg = c["bg+2"], bg = bg },
    VertSplit = { link = "WinSeparator" },
    StatusLine = { fg = c["fg-1"], bg = c["bg+1"] },
    StatusLineNC = { link = "StatusLine" },
    StatusLineTerm = { link = "StatusLine" },
    StatusLineTermNC = { link = "StatusLineNC" },
    TabLine = { fg = c["fg-1"], bg = c["bg+1"] },
    TabLineFill = { bg = c["bg+1"] },
    TabLineSel = { fg = c.yellow, bg = c["bg-1"], bold = o.bold },
    WinBar = { fg = c.fg, bg = bg },
    WinBarNC = { fg = c["niagara-1"], bg = bg },

    Pmenu = { fg = c.fg, bg = float },
    PmenuSel = { fg = c.fg, bg = c["bg+2"], bold = o.bold },
    PmenuKind = { fg = r.type, bg = float },
    PmenuKindSel = { fg = r.type, bg = c["bg+2"] },
    PmenuExtra = { fg = c["fg-1"], bg = float },
    PmenuExtraSel = { fg = c["fg-1"], bg = c["bg+2"] },
    PmenuSbar = { bg = float },
    PmenuThumb = { bg = c["bg+2"] },
    PmenuBorder = { fg = c["bg+2"], bg = float },
    PmenuMatch = { fg = c.purple, bg = float, bold = o.bold },
    PmenuMatchSel = { fg = c.yellow, bg = c["bg+2"], bold = o.bold },
    WildMenu = { link = "PmenuSel" },

    ModeMsg = { fg = c.fg, bold = o.bold },
    MsgArea = { fg = c.fg },
    MsgSeparator = { link = "WinSeparator" },
    MoreMsg = { fg = c.neon },
    Question = { fg = c.yellow },
    ErrorMsg = { fg = r.error },
    WarningMsg = { fg = r.warn },
    OkMsg = { fg = r.ok },
    StderrMsg = { link = "ErrorMsg" },

    SpellBad = { sp = r.error, undercurl = true },
    SpellCap = { sp = r.warn, undercurl = true },
    SpellLocal = { sp = r.hint, undercurl = true },
    SpellRare = { sp = r.info, undercurl = true },

    -- Diffs tint the line and keep its syntax colors.
    DiffAdd = { bg = blend(r.add, c.bg, 0.15) },
    DiffChange = { bg = blend(r.change, c.bg, 0.08) },
    DiffDelete = { fg = blend(r.delete, c.bg, 0.6), bg = blend(r.delete, c.bg, 0.15) },
    DiffText = { bg = blend(r.change, c.bg, 0.25) },
    Added = { fg = r.add },
    Changed = { fg = r.change },
    Removed = { fg = r.delete },
    diffAdded = { link = "Added" },
    diffChanged = { link = "Changed" },
    diffRemoved = { link = "Removed" },
    diffLine = { fg = c.purple },
    diffFile = { fg = c.yellow, bold = o.bold },
    diffIndexLine = { fg = c["niagara-1"] },
    diffComment = { fg = c["niagara-1"] },

    qfFileName = { fg = c.purple },
    qfLineNr = { fg = c["fg-2"] },

    healthError = { fg = r.error },
    healthWarning = { fg = r.warn },
    healthSuccess = { fg = r.ok },
  }
end

local function lsp(c, r, o)
  local hl = {
    LspReferenceText = { bg = c["bg+2"] },
    LspReferenceRead = { link = "LspReferenceText" },
    LspReferenceWrite = { link = "LspReferenceText" },
    LspReferenceTarget = { link = "LspReferenceText" },
    LspInlayHint = { fg = c["fg-2"], bg = o.transparent and "NONE" or c["bg-1"] },
    LspCodeLens = { fg = c["fg-2"] },
    LspCodeLensSeparator = { fg = c["bg+3"] },
    LspSignatureActiveParameter = { fg = c.yellow, bold = o.bold, underline = true },
    LspInfoBorder = { link = "FloatBorder" },

    DiagnosticUnnecessary = { fg = c["fg-2"] },
    DiagnosticDeprecated = { sp = c["fg-2"], strikethrough = true },
  }
  for severity, color in pairs { Error = r.error, Warn = r.warn, Info = r.info, Hint = r.hint, Ok = r.ok } do
    hl["Diagnostic" .. severity] = { fg = color }
    hl["DiagnosticVirtualText" .. severity] = { fg = color, bg = blend(color, c.bg, 0.1) }
    hl["DiagnosticVirtualLines" .. severity] = { link = "DiagnosticVirtualText" .. severity }
    hl["DiagnosticUnderline" .. severity] = { sp = color, undercurl = true }
    hl["DiagnosticFloating" .. severity] = { link = "Diagnostic" .. severity }
    hl["DiagnosticSign" .. severity] = { link = "Diagnostic" .. severity }
  end
  return hl
end

local function syntax(c, r, o)
  local hl = {
    -- Structure
    ["@keyword"] = { fg = r.keyword },
    ["@keyword.modifier"] = { fg = r.keyword },
    ["@keyword.type"] = { fg = r.keyword },
    ["@keyword.function"] = { fg = r.keyword },
    ["@keyword.import"] = { fg = r.keyword },
    ["@keyword.operator"] = { fg = r.keyword },
    ["@keyword.directive"] = { fg = r.keyword },
    ["@keyword.directive.define"] = { fg = r.keyword },
    ["@keyword.debug"] = { fg = r.keyword, bold = o.bold },
    ["@keyword.conditional"] = { fg = r.keyword, bold = o.bold },
    ["@keyword.conditional.ternary"] = { fg = r.operator },
    ["@keyword.repeat"] = { fg = r.keyword, bold = o.bold },
    ["@keyword.return"] = { fg = r.keyword, bold = o.bold },
    ["@keyword.exception"] = { fg = r.keyword, bold = o.bold },
    ["@keyword.coroutine"] = { fg = r.keyword, bold = o.bold },
    ["@label"] = { fg = r.keyword },
    ["@variable.builtin"] = { fg = r.keyword },
    ["@variable.parameter.builtin"] = { fg = r.keyword },

    -- Values
    ["@string"] = { fg = r.string },
    ["@string.documentation"] = { fg = r.comment },
    ["@character"] = { fg = r.string },
    ["@string.escape"] = { fg = r.special },
    ["@string.regexp"] = { fg = r.special },
    ["@string.special"] = { fg = r.special },
    ["@string.special.symbol"] = { fg = r.literal },
    ["@string.special.path"] = { fg = r.string, underline = true },
    -- A URL inside a string is still a string; the underline marks the link.
    ["@string.special.url"] = { fg = r.string, underline = true },
    ["@character.special"] = { fg = r.special },
    ["@character.printf"] = { fg = r.special },
    ["@number"] = { fg = r.literal },
    ["@number.float"] = { fg = r.literal },
    ["@boolean"] = { fg = r.literal },
    ["@constant"] = { fg = r.constant },
    ["@constant.builtin"] = { fg = r.literal },
    ["@constant.macro"] = { fg = r.constant },

    -- Shapes
    ["@type"] = { fg = r.type },
    ["@type.builtin"] = { fg = r.type },
    ["@type.definition"] = { fg = r.type, bold = o.bold },
    ["@constructor"] = { fg = r.type },
    ["@attribute"] = { fg = r.type },
    ["@attribute.builtin"] = { fg = r.type },
    ["@module"] = { fg = r.glue },
    ["@module.builtin"] = { fg = r.glue },
    ["@tag"] = { fg = r.type },
    ["@tag.builtin"] = { fg = r.type },
    ["@tag.attribute"] = { fg = r.glue },
    ["@tag.delimiter"] = { fg = r.punct },

    -- Behavior
    ["@function"] = { fg = r.func_def, bold = o.bold },
    ["@function.method"] = { fg = r.func_def, bold = o.bold },
    ["@function.call"] = { fg = r.func },
    ["@function.method.call"] = { fg = r.func },
    ["@function.builtin"] = { fg = r.func },
    ["@function.macro"] = { fg = r.type },

    -- Names
    ["@variable"] = { fg = r.name },
    ["@variable.member"] = { fg = r.name },
    ["@property"] = { fg = r.name },
    ["@variable.parameter"] = { fg = r.param },

    -- Glue
    ["@punctuation.bracket"] = { fg = r.punct },
    ["@punctuation.delimiter"] = { fg = r.punct },
    ["@punctuation.special"] = { fg = r.special },
    ["@operator"] = { fg = r.operator },
    -- rainbow-delimiters, when installed: one hue per nesting depth, none
    -- shared with strings (neon) or operators (rose).
    RainbowDelimiterRed = { fg = c.yellow },
    RainbowDelimiterYellow = { fg = c.purple },
    RainbowDelimiterBlue = { fg = c.teal },
    RainbowDelimiterOrange = { fg = c.brown },
    RainbowDelimiterGreen = { fg = c.niagara },
    RainbowDelimiterViolet = { fg = c["fg-1"] },
    RainbowDelimiterCyan = { fg = c.fg },

    -- Notes
    ["@comment"] = { fg = r.comment },
    ["@comment.documentation"] = { fg = r.comment },
    ["@comment.todo"] = { fg = c.bg, bg = c.yellow, bold = o.bold },
    ["@comment.note"] = { fg = c.bg, bg = c.purple, bold = o.bold },
    ["@comment.warning"] = { fg = c.bg, bg = c.brown, bold = o.bold },
    ["@comment.error"] = { fg = c.bg, bg = c.red, bold = o.bold },

    -- Prose
    ["@markup.heading"] = { fg = c.yellow, bold = o.bold },
    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.link"] = { fg = c.purple },
    ["@markup.link.label"] = { fg = c.purple },
    ["@markup.link.url"] = { fg = c.purple, underline = true },
    ["@markup.raw"] = { fg = r.string },
    ["@markup.math"] = { fg = r.literal },
    ["@markup.list"] = { fg = c.yellow },
    ["@markup.list.checked"] = { fg = r.ok },
    ["@markup.list.unchecked"] = { fg = c["fg-1"] },
    ["@markup.quote"] = { fg = r.glue },
    ["@diff.plus"] = { fg = r.add },
    ["@diff.minus"] = { fg = r.delete },
    ["@diff.delta"] = { fg = r.change },

    -- Legacy groups, for filetypes without Treesitter.
    Comment = { link = "@comment" },
    SpecialComment = { fg = r.comment, bold = o.bold },
    String = { link = "@string" },
    Character = { link = "@character" },
    Number = { link = "@number" },
    Float = { link = "@number.float" },
    Boolean = { link = "@boolean" },
    Constant = { link = "@constant" },
    Identifier = { link = "@variable" },
    Function = { link = "@function.call" },
    Statement = { link = "@keyword" },
    Keyword = { link = "@keyword" },
    Conditional = { link = "@keyword.conditional" },
    Repeat = { link = "@keyword.repeat" },
    Label = { link = "@label" },
    Exception = { link = "@keyword.exception" },
    Operator = { link = "@operator" },
    Type = { link = "@type" },
    StorageClass = { link = "@keyword.modifier" },
    Structure = { link = "@type" },
    Typedef = { link = "@type.definition" },
    PreProc = { link = "@keyword.directive" },
    PreCondit = { link = "@keyword.directive" },
    Include = { link = "@keyword.import" },
    Define = { link = "@keyword.directive.define" },
    Macro = { link = "@function.macro" },
    Special = { link = "@string.special" },
    SpecialChar = { link = "@character.special" },
    Delimiter = { link = "@punctuation.delimiter" },
    Tag = { link = "@tag" },
    Todo = { link = "@comment.todo" },
    Debug = { fg = r.special },
    Underlined = { underline = true },
    Bold = { bold = true },
    Italic = { italic = true },
    Ignore = { fg = c["fg-2"] },
    Error = { fg = r.error },

    -- night-owl.nvim's ecma queries load under every colorscheme; its
    -- const-name capture would otherwise paint every const binding aqua.
    ["@constant.identifier"] = { link = "@variable" },
    -- poimandres.nvim's JS/TS queries group false, null and undefined as
    -- "falsy" constants; keep them with true and the other literals.
    ["@constant.falsy"] = { link = "@constant.builtin" },
    -- Markdown: it paints whole headings over their inline code and links,
    -- styles a checked box like a TODO label, and makes code-span backticks
    -- purple around neon code. Vimscript's if/endif would lose their bold.
    ["@text.title"] = {},
    ["@text.todo.checked"] = {},
    ["@text.literal"] = {},
    ["@keyword.if"] = { link = "@keyword.conditional" },
    ["@string.regex"] = { link = "@string.regexp" },
    ["@string.regexFlags"] = { link = "@string.regexp" },
  }

  -- JSX and HTML mark the text inside <a>, <h1>-<h6> and <code> as Markdown
  -- would; that text is page copy, like any other text node, so only Markdown
  -- keeps the link, heading and code colors. Each heading level needs its own
  -- group: @markup.heading.1.tsx falls back to @markup.heading.1, not .tsx.
  local copy = { "link.label", "raw", "heading" }
  for level = 1, 6 do
    table.insert(copy, "heading." .. level)
  end
  for _, lang in ipairs { "tsx", "javascript", "html", "vue", "svelte", "astro" } do
    for _, capture in ipairs(copy) do
      hl["@markup." .. capture .. "." .. lang] = { fg = c.fg }
    end
  end
  return hl
end

-- LSP semantic tokens: add what Treesitter can't see, and leave functions
-- and methods to Treesitter, which tells definitions from calls.
local function semantic(c, r)
  return {
    -- ty tags annotation aliases (`StorageDep = Annotated[...]`) as variables,
    -- which would paint them over Treesitter's @type in parameter annotations.
    ["@lsp.type.variable"] = {},
    ["@lsp.type.function"] = {},
    ["@lsp.type.method"] = {},
    -- poimandres.nvim's python query paints the whole decorator, arguments
    -- included, at priority 200; the stock queries still color its name.
    ["@lsp.type.decorator"] = {},
    -- Comment tokens would cover Treesitter's TODO/NOTE labels.
    ["@lsp.type.comment"] = {},
    ["@lsp.type.class"] = { link = "@type" },
    ["@lsp.type.interface"] = { link = "@type" },
    ["@lsp.type.struct"] = { link = "@type" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.type"] = { link = "@type" },
    ["@lsp.type.builtinType"] = { link = "@type.builtin" },
    ["@lsp.type.typeAlias"] = { link = "@type.definition" },
    ["@lsp.type.typeParameter"] = { fg = r.type },
    ["@lsp.type.namespace"] = { link = "@module" },
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.parameter"] = { link = "@variable.parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.macro"] = { link = "@function.macro" },
    ["@lsp.type.keyword"] = { link = "@keyword" },
    ["@lsp.type.modifier"] = { link = "@keyword.modifier" },
    ["@lsp.type.operator"] = { link = "@operator" },
    ["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
    ["@lsp.type.selfParameter"] = { link = "@variable.builtin" },
    ["@lsp.type.escapeSequence"] = { link = "@string.escape" },
    ["@lsp.type.formatSpecifier"] = { link = "@character.printf" },
    ["@lsp.type.regexp"] = { link = "@string.regexp" },
    ["@lsp.type.constant"] = { link = "@constant" },
    ["@lsp.type.unresolvedReference"] = { sp = r.warn, undercurl = true },
    ["@lsp.typemod.variable.readonly"] = { link = "@constant" },
    ["@lsp.typemod.field.readonly"] = { link = "@constant" },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.type.defaultLibrary"] = { link = "@type.builtin" },
    ["@lsp.typemod.class.defaultLibrary"] = { link = "@type.builtin" },
    ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.enumMember.defaultLibrary"] = { link = "@constant.builtin" },
    ["@lsp.type.label"] = { link = "@label" },
    ["@lsp.type.event"] = { link = "@keyword" },
    ["@lsp.typemod.keyword.async"] = { link = "@keyword.coroutine" },
    ["@lsp.mod.deprecated"] = { sp = c["fg-2"], strikethrough = true },
  }
end

-- Completion and breadcrumb kinds, by the role their symbol plays in code.
local function kinds(c, r)
  return {
    Text = c.fg,
    Method = r.func,
    Function = r.func,
    Constructor = r.type,
    Field = r.name,
    Variable = r.name,
    Class = r.type,
    Interface = r.type,
    Module = r.glue,
    Namespace = r.glue,
    Package = r.glue,
    Property = r.name,
    Unit = r.literal,
    Value = r.literal,
    Enum = r.type,
    Keyword = r.keyword,
    Snippet = r.operator,
    Color = r.literal,
    File = c.fg,
    Reference = r.glue,
    Folder = c.purple,
    EnumMember = r.constant,
    Constant = r.constant,
    Struct = r.type,
    Event = r.keyword,
    Operator = r.operator,
    TypeParameter = r.type,
    String = r.string,
    Number = r.literal,
    Boolean = r.literal,
    Array = r.type,
    Object = r.type,
    Key = r.name,
    Null = r.literal,
    Copilot = r.ok,
  }
end

local function plugins(c, r, o)
  local float = o.transparent and "NONE" or c["bg-1"]
  local sel = c["bg+2"]
  local bold = o.bold
  local hl = {
    -- Telescope: one flat float, the prompt title as the only accent.
    TelescopeNormal = { fg = c.fg, bg = float },
    TelescopePromptNormal = { fg = c.fg, bg = float },
    TelescopeResultsNormal = { fg = c.fg, bg = float },
    TelescopePreviewNormal = { fg = c.fg, bg = float },
    TelescopeBorder = { fg = c["bg+2"], bg = float },
    TelescopePromptBorder = { link = "TelescopeBorder" },
    TelescopeResultsBorder = { link = "TelescopeBorder" },
    TelescopePreviewBorder = { link = "TelescopeBorder" },
    TelescopeTitle = { fg = c["fg-1"], bg = float, bold = bold },
    TelescopePromptTitle = { fg = c.yellow, bg = float, bold = bold },
    TelescopeResultsTitle = { link = "TelescopeTitle" },
    TelescopePreviewTitle = { link = "TelescopeTitle" },
    TelescopePromptPrefix = { fg = c.yellow, bg = float },
    TelescopePromptCounter = { fg = c["fg-1"], bg = float },
    TelescopeMatching = { fg = c.yellow, bold = bold },
    TelescopeFileIcon = { fg = c.purple },
    TelescopeResultsComment = { fg = c["fg-1"] },
    TelescopeResultsDiffUntracked = { fg = c["niagara-1"] },
    TelescopeSelection = { fg = c.fg, bg = sel, bold = bold },
    TelescopeSelectionCaret = { fg = c.yellow, bg = sel, bold = bold },
    TelescopeMultiSelection = { fg = c.purple, bg = sel },
    TelescopeMultiIcon = { fg = c.purple },

    -- File trees
    NvimTreeNormal = { fg = c.fg, bg = float },
    NvimTreeNormalNC = { link = "NvimTreeNormal" },
    NvimTreeWinSeparator = { fg = c["bg+2"], bg = float },
    NvimTreeCursorLine = { bg = c["bg+1"] },
    NvimTreeRootFolder = { fg = c.yellow, bold = bold },
    NvimTreeFolderName = { fg = c.purple },
    NvimTreeOpenedFolderName = { fg = c.purple, bold = bold },
    NvimTreeEmptyFolderName = { fg = c["fg-1"] },
    NvimTreeFolderIcon = { fg = c.purple },
    NvimTreeIndentMarker = { fg = c["bg+2"] },
    NvimTreeOpenedFile = { fg = c.strong, bold = bold },
    NvimTreeSpecialFile = { fg = c.yellow, underline = true },
    NvimTreeSymlink = { fg = c.aqua },
    NvimTreeGitNew = { fg = r.add },
    NvimTreeGitDirty = { fg = r.change },
    NvimTreeGitStaged = { fg = r.add },
    NvimTreeGitDeleted = { fg = r.delete },
    NvimTreeGitMerge = { fg = c.rose },
    NvimTreeGitIgnored = { fg = c["fg-2"] },
    NeoTreeNormal = { fg = c.fg, bg = float },
    NeoTreeNormalNC = { link = "NeoTreeNormal" },
    NeoTreeWinSeparator = { fg = c["bg+2"], bg = float },
    NeoTreeCursorLine = { bg = c["bg+1"] },
    NeoTreeRootName = { fg = c.yellow, bold = bold },
    NeoTreeDirectoryName = { fg = c.purple },
    NeoTreeDirectoryIcon = { fg = c.purple },
    NeoTreeFileName = { fg = c.fg },
    NeoTreeFileNameOpened = { fg = c.strong, bold = bold },
    NeoTreeIndentMarker = { fg = c["bg+2"] },
    NeoTreeExpander = { fg = c["fg-2"] },
    NeoTreeDimText = { fg = c["fg-2"] },
    NeoTreeDotfile = { fg = c["fg-2"] },
    NeoTreeSymbolicLinkTarget = { fg = c.aqua },
    NeoTreeGitAdded = { fg = r.add },
    NeoTreeGitModified = { fg = r.change },
    NeoTreeGitDeleted = { fg = r.delete },
    NeoTreeGitConflict = { fg = c.rose, bold = bold },
    NeoTreeGitUntracked = { fg = c.aqua },
    NeoTreeGitIgnored = { fg = c["fg-2"] },
    NeoTreeFloatBorder = { link = "FloatBorder" },
    NeoTreeFloatTitle = { link = "FloatTitle" },
    NeoTreeTitleBar = { fg = c.bg, bg = c.yellow, bold = bold },
    OilNormalFloat = { link = "NormalFloat" },
    OilFloatBorder = { link = "FloatBorder" },
    OilFooter = { fg = c["fg-1"], bg = float },
    OilSignColumn = { bg = float },
    OilCursorLine = { link = "CursorLine" },
    OilDir = { fg = c.fg, bold = bold },
    OilDirIcon = { fg = c["fg-1"] },
    OilFileIcon = { fg = c["fg-1"] },
    OilHidden = { fg = c["fg-1"] },
    OilDirHidden = { fg = c["fg-1"], bold = bold },
    OilLink = { fg = c["fg-1"], underline = true },
    OilMtime = { fg = c["fg-1"] },
    OilGitAuthor = { fg = c["fg-1"] },
    OilFile = { fg = c.fg },
    OilFileHidden = { link = "OilHidden" },
    -- Oil links these to Comment, which would paint them amber.
    OilEmpty = { fg = c["fg-2"] },
    OilLinkTarget = { fg = c["fg-2"] },
    OilTrashSourcePath = { fg = c["fg-2"] },
    OilLinkHidden = { link = "OilHidden" },
    OilLinkTargetHidden = { link = "OilHidden" },
    OilOrphanLink = { fg = r.error, underline = true },
    OilOrphanLinkTarget = { fg = r.error },
    OilOrphanLinkHidden = { link = "OilOrphanLink" },
    OilOrphanLinkTargetHidden = { link = "OilOrphanLinkTarget" },
    OilSocket = { fg = c.rose },
    OilSocketHidden = { link = "OilHidden" },
    OilCreate = { fg = r.add },
    OilCopy = { fg = r.add },
    OilMove = { fg = c.brown },
    OilChange = { fg = c.brown },
    OilDelete = { fg = r.delete },
    OilRestore = { fg = r.add },
    OilPurge = { fg = r.delete },
    OilTrash = { fg = r.delete },

    -- which-key
    WhichKeyNormal = { link = "NormalFloat" },
    WhichKeyBorder = { link = "FloatBorder" },
    WhichKeyTitle = { link = "FloatTitle" },
    WhichKey = { fg = c.yellow },
    WhichKeyGroup = { fg = c.purple },
    WhichKeyDesc = { fg = c.fg },
    WhichKeySeparator = { fg = c["bg+3"] },
    WhichKeyValue = { fg = c["fg-1"] },
    WhichKeyIcon = { fg = c.slate },

    -- Gitsigns: signs in full color, line and word highlights as tints, and
    -- staged hunks at half strength.
    GitSignsAdd = { fg = r.add },
    GitSignsChange = { fg = r.change },
    GitSignsDelete = { fg = r.delete },
    GitSignsTopdelete = { link = "GitSignsDelete" },
    GitSignsChangedelete = { link = "GitSignsChange" },
    GitSignsUntracked = { fg = c.aqua },
    GitSignsAddNr = { link = "GitSignsAdd" },
    GitSignsChangeNr = { link = "GitSignsChange" },
    GitSignsDeleteNr = { link = "GitSignsDelete" },
    GitSignsAddLn = { link = "DiffAdd" },
    GitSignsChangeLn = { link = "DiffChange" },
    GitSignsDeleteLn = { link = "DiffDelete" },
    GitSignsAddInline = { bg = blend(r.add, c.bg, 0.3) },
    GitSignsChangeInline = { bg = blend(r.change, c.bg, 0.3) },
    GitSignsDeleteInline = { bg = blend(r.delete, c.bg, 0.3) },
    GitSignsAddPreview = { link = "DiffAdd" },
    GitSignsDeletePreview = { link = "DiffDelete" },
    GitSignsStagedAdd = { fg = blend(r.add, c.bg, 0.5) },
    GitSignsStagedChange = { fg = blend(r.change, c.bg, 0.5) },
    GitSignsStagedDelete = { fg = blend(r.delete, c.bg, 0.5) },
    GitSignsStagedTopdelete = { link = "GitSignsStagedDelete" },
    GitSignsStagedChangedelete = { link = "GitSignsStagedChange" },
    GitSignsCurrentLineBlame = { fg = c["fg-1"] },

    -- Indent guides: barely there; the active scope a step brighter.
    IblIndent = { fg = c["bg+1"] },
    IblWhitespace = { fg = c["bg+1"] },
    IblScope = { fg = c.purple },
    MiniIndentscopeSymbol = { fg = c["bg+1"] },
    MiniCursorword = { bg = c["bg+1"] },
    MiniCursorwordCurrent = { bg = "NONE" },
    MiniStarterHeader = { fg = c.yellow, bold = bold },
    MiniStarterSection = { fg = c["fg-1"], bold = bold },
    MiniStarterCurrent = { fg = c.fg, bg = sel, bold = bold },
    MiniStarterItem = { fg = c.fg },
    MiniStarterItemPrefix = { fg = c.yellow },
    MiniStarterQuery = { fg = c.neon },
    MiniStarterFooter = { fg = c["fg-1"] },

    -- Completion: nvim-cmp and blink.cmp.
    CmpItemAbbr = { fg = c.fg },
    CmpItemAbbrMatch = { fg = c.yellow, bold = bold },
    CmpItemAbbrMatchFuzzy = { fg = c.yellow },
    CmpItemAbbrDeprecated = { fg = c["fg-2"], strikethrough = true },
    CmpItemMenu = { fg = c["fg-1"] },
    CmpItemKind = { fg = r.type },
    CmpGhostText = { fg = c["fg-2"] },
    CmpDocumentation = { link = "NormalFloat" },
    CmpDocumentationBorder = { link = "FloatBorder" },
    BlinkCmpMenu = { link = "Pmenu" },
    BlinkCmpMenuBorder = { link = "FloatBorder" },
    BlinkCmpMenuSelection = { link = "PmenuSel" },
    BlinkCmpScrollBarThumb = { link = "PmenuThumb" },
    BlinkCmpScrollBarGutter = { link = "PmenuSbar" },
    BlinkCmpLabel = { fg = c.fg },
    BlinkCmpLabelMatch = { fg = c.yellow, bold = bold },
    BlinkCmpLabelDeprecated = { fg = c["fg-2"], strikethrough = true },
    BlinkCmpLabelDetail = { fg = c["fg-1"] },
    BlinkCmpLabelDescription = { fg = c["fg-1"] },
    BlinkCmpSource = { fg = c["fg-2"] },
    BlinkCmpKind = { fg = r.type },
    BlinkCmpDoc = { link = "NormalFloat" },
    BlinkCmpDocBorder = { link = "FloatBorder" },
    BlinkCmpDocCursorLine = { bg = sel },
    BlinkCmpSignatureHelp = { link = "NormalFloat" },
    BlinkCmpSignatureHelpBorder = { link = "FloatBorder" },
    BlinkCmpSignatureHelpActiveParameter = { link = "LspSignatureActiveParameter" },
    BlinkCmpGhostText = { fg = c["fg-2"] },

    -- Messages and notifications
    NoiceCmdlinePopup = { link = "NormalFloat" },
    NoiceCmdlinePopupBorder = { link = "FloatBorder" },
    NoiceCmdlinePopupTitle = { link = "FloatTitle" },
    NoiceCmdlinePopupBorderSearch = { link = "FloatBorder" },
    NoiceCmdlineIcon = { fg = c.purple },
    NoiceCmdlineIconSearch = { fg = c.yellow },
    NoicePopupmenu = { link = "Pmenu" },
    NoicePopupmenuBorder = { link = "FloatBorder" },
    NoicePopupmenuSelected = { link = "PmenuSel" },
    NoiceConfirmBorder = { link = "FloatBorder" },
    NotifyBackground = { bg = float },
    TroubleNormal = { fg = c.fg, bg = float },
    TroubleNormalNC = { link = "TroubleNormal" },
    TroubleText = { fg = c.fg },
    TroubleCount = { fg = c.purple, bold = bold },
    TroubleIndent = { fg = c["bg+2"] },
    TroublePos = { fg = c["fg-2"] },

    -- Git and diff views
    DiffviewNormal = { fg = c.fg, bg = float },
    DiffviewWinSeparator = { fg = c["bg+2"], bg = float },
    DiffviewFilePanelTitle = { fg = c.yellow, bold = bold },
    DiffviewFilePanelCounter = { fg = c.purple, bold = bold },
    DiffviewFilePanelRootPath = { fg = c["fg-1"] },
    DiffviewFilePanelFileName = { fg = c.fg },
    DiffviewFilePanelPath = { fg = c["fg-2"] },
    DiffviewFolderName = { fg = c.purple },
    DiffviewStatusAdded = { fg = r.add },
    DiffviewStatusUntracked = { fg = c.aqua },
    DiffviewStatusModified = { fg = r.change },
    DiffviewStatusRenamed = { fg = c.brown },
    DiffviewStatusDeleted = { fg = r.delete },
    DiffviewFilePanelInsertions = { fg = r.add },
    DiffviewFilePanelDeletions = { fg = r.delete },
    fugitiveHeader = { fg = c.yellow, bold = bold },
    fugitiveHash = { fg = c.purple },
    fugitiveStagedHeading = { fg = r.add, bold = bold },
    fugitiveUnstagedHeading = { fg = r.change, bold = bold },
    fugitiveUntrackedHeading = { fg = c.aqua, bold = bold },

    -- Debugging and tests
    DapBreakpoint = { fg = r.error },
    DapBreakpointCondition = { fg = r.warn },
    DapLogPoint = { fg = r.info },
    DapStopped = { fg = r.ok },
    DapStoppedLine = { bg = blend(r.warn, c.bg, 0.12) },
    NvimDapVirtualText = { fg = c["fg-2"] },
    NeotestPassed = { fg = r.ok },
    NeotestFailed = { fg = r.error },
    NeotestRunning = { fg = r.warn },
    NeotestSkipped = { fg = c["fg-2"] },
    NeotestUnknown = { fg = c["fg-2"] },
    NeotestWatching = { fg = c.aqua },
    NeotestFile = { fg = c.fg },
    NeotestDir = { fg = c.purple },
    NeotestNamespace = { fg = c.purple },
    NeotestTest = { fg = c.fg },
    NeotestAdapterName = { fg = c.yellow, bold = bold },
    NeotestFocused = { bold = true, underline = true },
    NeotestIndent = { fg = c["bg+2"] },
    NeotestExpandMarker = { fg = c["bg+3"] },
    NeotestWinSelect = { fg = c.yellow, bold = bold },
    NeotestMarked = { fg = c.rose, bold = bold },
    NeotestTarget = { fg = r.error },

    -- Markdown rendering: headings keep the heading-per-depth hues on a tint.
    RenderMarkdownCode = { bg = c["bg-1"] },
    RenderMarkdownCodeInline = { bg = c["bg+1"] },
    RenderMarkdownBullet = { fg = c.yellow },
    RenderMarkdownDash = { fg = c["bg+3"] },
    RenderMarkdownQuote = { fg = c["fg-1"] },
    RenderMarkdownLink = { fg = c.purple },
    RenderMarkdownChecked = { fg = r.ok },
    RenderMarkdownUnchecked = { fg = c["fg-1"] },
    RenderMarkdownTableHead = { fg = c["fg-1"] },
    RenderMarkdownTableRow = { fg = c["bg+3"] },

    -- Everything else
    NavicText = { fg = c["fg-1"], bg = o.transparent and "NONE" or c.bg },
    NavicSeparator = { fg = c["bg+2"], bg = o.transparent and "NONE" or c.bg },
    SatelliteBar = { bg = c["bg+2"] },
    SatelliteCursor = { fg = c["fg-1"] },
    SatelliteSearch = { fg = c.yellow },
    SatelliteSearchCurrent = { fg = c.yellow, bold = bold },
    HarpoonWindow = { link = "NormalFloat" },
    HarpoonBorder = { link = "FloatBorder" },
    UfoFoldedEllipsis = { fg = c["fg-2"] },
    TreesitterContext = { bg = float },
    TreesitterContextLineNumber = { fg = c["bg+4"], bg = float },
    TreesitterContextBottom = { sp = c["bg+2"], underline = true },
  }

  -- oil-git-status: two columns, staged (index) then unstaged (working
  -- tree); both use the git hue, staged in bold. Its defaults link every
  -- status to the Info/Warn diagnostic colors.
  local git_status = {
    Added = r.add,
    Copied = r.add,
    Modified = r.change,
    Deleted = r.delete,
    Renamed = c.brown,
    TypeChanged = c.brown,
    Unmerged = c.rose,
    Untracked = c.aqua,
    Ignored = c["fg-2"],
    Unmodified = c["fg-2"],
  }
  hl.OilGitStatusIndex = { fg = r.change, bold = bold }
  hl.OilGitStatusWorkingTree = { fg = r.change }
  for status, color in pairs(git_status) do
    hl["OilGitStatusIndex" .. status] = { fg = color, bold = bold }
    hl["OilGitStatusWorkingTree" .. status] = { fg = color }
  end

  -- barbar: the current and visible buffers sit on the editor background,
  -- the rest recede into the bar.
  local editor_bg = o.transparent and "NONE" or c.bg
  local bar = c["bg+1"]
  local marks = {
    Mod = r.change,
    Sign = c["bg+2"],
    Index = c["fg-2"],
    Number = c["fg-2"],
    ADDED = r.add,
    CHANGED = r.change,
    DELETED = r.delete,
    ERROR = r.error,
    WARN = r.warn,
    INFO = r.info,
    HINT = r.hint,
  }
  for state, base in pairs {
    Current = { fg = c.fg, bg = editor_bg, bold = bold },
    Visible = { fg = c["fg-1"], bg = editor_bg },
    Alternate = { fg = c["fg-1"], bg = bar },
    Inactive = { fg = c["fg-2"], bg = bar },
  } do
    hl["Buffer" .. state] = base
    for mark, color in pairs(marks) do
      hl["Buffer" .. state .. mark] = { fg = color, bg = base.bg }
    end
    hl["Buffer" .. state .. "Target"] = { fg = r.error, bg = base.bg, bold = bold }
  end
  hl.BufferTabpageFill = { bg = bar }
  hl.BufferTabpages = { fg = c.yellow, bg = bar, bold = bold }
  hl.BufferTabpagesSep = { fg = c["bg+2"], bg = bar }
  hl.BufferOffset = { fg = c["fg-1"], bg = float }

  for level, color in ipairs { c.yellow, c.purple, c.slate, c.aqua, c.rose, c.brown } do
    hl["RenderMarkdownH" .. level] = { fg = color, bold = bold }
    hl["RenderMarkdownH" .. level .. "Bg"] = { bg = blend(color, c.bg, 0.12) }
  end
  for name, color in pairs(kinds(c, r)) do
    hl["CmpItemKind" .. name] = { fg = color }
    hl["BlinkCmpKind" .. name] = { fg = color }
    hl["NavicIcons" .. name] = { fg = color, bg = o.transparent and "NONE" or c.bg }
  end
  return hl
end

-- The Treesitter groups each `styles` entry applies to; the legacy groups
-- link to these, so they follow.
local styled = {
  comments = { "^@comment$", "^@comment%.documentation$", "^@string%.documentation$" },
  keywords = { "^@keyword", "^@label$" },
  strings = { "^@string$", "^@string%.special", "^@character$" },
  functions = { "^@function" },
  variables = { "^@variable", "^@property$" },
  types = { "^@type", "^@constructor$" },
}

local function apply_styles(hl, styles)
  for name, patterns in pairs(styled) do
    local style = styles[name]
    if style and next(style) then
      for group, spec in pairs(hl) do
        if not spec.link then
          for _, pattern in ipairs(patterns) do
            if group:find(pattern) then
              hl[group] = vim.tbl_extend("force", spec, style)
              break
            end
          end
        end
      end
    end
  end
end

--- Every highlight group for palette variant `c` under options `o`.
function M.get(c, o)
  local r = roles(c)
  local hl = {}
  -- Later sections win: plugins can override editor groups, never the
  -- reverse, and the user's on_highlights runs last in init.lua.
  for _, section in ipairs {
    editor(c, r, o),
    syntax(c, r, o),
    semantic(c, r),
    lsp(c, r, o),
    plugins(c, r, o),
  } do
    for group, spec in pairs(section) do
      hl[group] = spec
    end
  end
  apply_styles(hl, o.styles)
  return hl
end

--- ANSI colors for :terminal, in the order of g:terminal_color_0..15.
function M.terminal(c)
  return {
    c["bg+1"],
    c.red,
    c.neon,
    c.yellow,
    c.purple,
    c.rose,
    c.teal,
    c.fg,
    c["niagara-1"],
    c["red+1"],
    c["neon+1"],
    c["yellow+1"],
    c["purple+1"],
    c["rose+1"],
    c["teal+1"],
    c["fg+1"],
  }
end

return M
