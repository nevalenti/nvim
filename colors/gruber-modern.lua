-- Gruber Modern: gruber-darker.nvim's highlight groups with the more vibrant
-- accents in lua/gruber-modern/palette.lua.
local Color = require "gruber-darker.color"
local palette = require "gruber-darker.palette"
local c = require "gruber-modern.palette"

-- The plugin builds its highlight tables when those modules are first
-- required, so drop them before and after loading with the swapped palette;
-- plain gruber-darker then still loads unchanged later in the session.
local function forget_highlights()
  for module in pairs(package.loaded) do
    if module:match "^gruber%-darker%.highlights" then
      package.loaded[module] = nil
    end
  end
end

-- Functions are slate, strings neon green and types purple, instead of
-- gruber's blue, green and quartz.
local roles = { niagara = c.slate, green = c.neon, quartz = c.purple }

local original = {}
for name, color in pairs(palette) do
  if c[name] then
    original[name] = color
    local hex = roles[name] or c[name]
    local swapped = Color.new(tonumber(hex:sub(2), 16))
    -- Color:to_string() drops leading zeros (#0F0E0C -> #f0e0c).
    swapped.to_string = function()
      return hex
    end
    palette[name] = swapped
  end
end
forget_highlights()
require("gruber-darker").load()
-- gruber-darker wipes every @lsp.* group on ColorScheme; this theme maps the
-- semantic tokens itself (see `syntax` below), so drop that autocmd.
vim.api.nvim_clear_autocmds { group = "GruberDarker", event = "ColorScheme" }
for name, color in pairs(original) do
  palette[name] = color
end
forget_highlights()

-- Syntax by role: each color has one job, and loudness follows importance.
--   structure  yellow       keywords; control flow in bold
--   values     neon/purple  strings in neon, every other literal in purple
--   shapes     purple       types and constructors; declarations in bold
--   behavior   white/slate  function definitions bold white, calls slate
--   names      fg           variables and members; parameters in italic
--   glue       white/gray   brackets white, other punctuation recedes
--   notes      amber        comments; TODO-style tags get a label
local glue = c["fg-1"]
local syntax = {
  -- Structure
  ["@keyword"] = { fg = c.yellow },
  ["@keyword.modifier"] = { fg = c.yellow },
  ["@keyword.type"] = { fg = c.yellow },
  ["@keyword.function"] = { fg = c.yellow },
  ["@keyword.import"] = { fg = c.yellow },
  ["@keyword.operator"] = { fg = c.yellow },
  ["@keyword.directive"] = { fg = c.yellow },
  ["@keyword.directive.define"] = { fg = c.yellow },
  ["@keyword.conditional"] = { fg = c.yellow, bold = true },
  ["@keyword.conditional.ternary"] = { fg = glue },
  ["@keyword.repeat"] = { fg = c.yellow, bold = true },
  ["@keyword.return"] = { fg = c.yellow, bold = true },
  ["@keyword.exception"] = { fg = c.yellow, bold = true },
  ["@keyword.coroutine"] = { fg = c.yellow, bold = true },
  ["@label"] = { fg = c.yellow },
  ["@variable.builtin"] = { fg = c.yellow, italic = true },

  -- Values
  ["@string"] = { fg = c.neon },
  ["@character"] = { fg = c.neon },
  ["@string.escape"] = { fg = c.yellow },
  ["@string.regexp"] = { fg = c.yellow },
  ["@string.special"] = { fg = c.yellow },
  ["@character.special"] = { fg = c.yellow },
  ["@number"] = { fg = c.purple },
  ["@number.float"] = { fg = c.purple },
  ["@boolean"] = { fg = c.purple },
  ["@constant"] = { fg = c.purple },
  ["@constant.builtin"] = { fg = c.purple, italic = true },
  ["@constant.macro"] = { fg = c.purple },

  -- Shapes
  ["@type"] = { fg = c.purple },
  ["@type.builtin"] = { fg = c.purple },
  ["@type.definition"] = { fg = c.purple, bold = true },
  ["@constructor"] = { fg = c.purple },
  ["@attribute"] = { fg = c.purple, italic = true },
  ["@attribute.builtin"] = { fg = c.purple, italic = true },
  ["@module"] = { fg = glue },
  ["@tag"] = { fg = c.purple },
  ["@tag.builtin"] = { fg = c.purple },
  ["@tag.attribute"] = { fg = glue, italic = true },
  ["@tag.delimiter"] = { fg = glue },

  -- Behavior
  ["@function"] = { fg = c.white, bold = true },
  ["@function.method"] = { fg = c.white, bold = true },
  ["@function.call"] = { fg = c.slate },
  ["@function.method.call"] = { fg = c.slate },
  ["@function.builtin"] = { fg = c.slate },
  ["@function.macro"] = { fg = c.purple },

  -- Names
  ["@variable"] = { fg = c.fg },
  ["@variable.member"] = { fg = c.fg },
  ["@property"] = { fg = c.fg },
  ["@variable.parameter"] = { fg = c.fg, italic = true },

  -- Glue
  ["@punctuation.bracket"] = { fg = c.white },
  ["@punctuation.delimiter"] = { fg = glue },
  ["@punctuation.special"] = { fg = c.yellow },
  ["@operator"] = { fg = glue },

  -- Notes
  ["@comment"] = { fg = c.brown, italic = true },
  ["@comment.documentation"] = { fg = c.brown, italic = true },
  ["@comment.todo"] = { fg = c.bg, bg = c.yellow, bold = true },
  ["@comment.note"] = { fg = c.bg, bg = c.purple, bold = true },
  ["@comment.warning"] = { fg = c.bg, bg = c.brown, bold = true },
  ["@comment.error"] = { fg = c.bg, bg = c.red, bold = true },

  -- Prose
  ["@markup.heading"] = { fg = c.yellow, bold = true },
  ["@markup.strong"] = { bold = true },
  ["@markup.italic"] = { italic = true },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@markup.link"] = { fg = c.purple },
  ["@markup.link.url"] = { fg = c.purple, underline = true },
  ["@markup.raw"] = { fg = c.neon },
  ["@markup.list"] = { fg = c.yellow },
  ["@markup.quote"] = { fg = glue, italic = true },
  ["@diff.plus"] = { fg = c.neon },
  ["@diff.minus"] = { fg = c.red },
  ["@diff.delta"] = { fg = c.yellow },

  -- Legacy groups, for filetypes without Treesitter.
  Comment = { link = "@comment" },
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
  Exception = { link = "@keyword.exception" },
  Operator = { link = "@operator" },
  Type = { link = "@type" },
  StorageClass = { link = "@keyword.modifier" },
  Structure = { link = "@type" },
  Typedef = { link = "@type.definition" },
  PreProc = { link = "@keyword.directive" },
  Include = { link = "@keyword.import" },
  Define = { link = "@keyword.directive.define" },
  Macro = { link = "@function.macro" },
  Special = { link = "@string.special" },
  SpecialChar = { link = "@character.special" },
  Delimiter = { link = "@punctuation.delimiter" },
  Tag = { link = "@tag" },
  Title = { link = "@markup.heading" },
  Todo = { link = "@comment.todo" },
  Directory = { fg = c.purple, bold = true },
  Question = { fg = c.yellow },

  -- night-owl.nvim's ecma queries load under every colorscheme; its
  -- const-name capture would otherwise inherit @constant's purple.
  ["@constant.identifier"] = { link = "@variable" },
  ["@string.regex"] = { link = "@string.regexp" },
  ["@string.regexFlags"] = { link = "@string.regexp" },

  -- LSP semantic tokens: add what Treesitter can't see, and leave functions
  -- and methods to Treesitter, which tells definitions from calls.
  ["@lsp.type.function"] = {},
  ["@lsp.type.method"] = {},
  ["@lsp.type.class"] = { link = "@type" },
  ["@lsp.type.interface"] = { link = "@type" },
  ["@lsp.type.struct"] = { link = "@type" },
  ["@lsp.type.enum"] = { link = "@type" },
  ["@lsp.type.typeParameter"] = { fg = c.purple, italic = true },
  ["@lsp.type.namespace"] = { link = "@module" },
  ["@lsp.type.enumMember"] = { link = "@constant" },
  ["@lsp.type.parameter"] = { link = "@variable.parameter" },
  ["@lsp.typemod.variable.readonly"] = { link = "@constant" },
  ["@lsp.typemod.field.readonly"] = { link = "@constant" },
  ["@lsp.type.constant"] = { link = "@constant" },
}
for group, highlight in pairs(syntax) do
  vim.api.nvim_set_hl(0, group, highlight)
end

vim.g.colors_name = "gruber-modern"
