-- Gruber Modern: gruber-darker.nvim's backgrounds, grays and hues, with the
-- accents rebuilt in OKLCH around the neon green. Each syntax role owns its
-- own slice of the hue wheel, 35-60 degrees from its neighbours:
--   param 32 (salmon), comment 62 (amber), keyword 98 (yellow),
--   string 142 (neon), literal 196 (cyan), call 258 (blue),
--   type 312 (violet), operator 358 (pink)
-- and every color has enough chroma that hue, not just lightness, tells it
-- apart. In OKLab, no two roles (plain text and punctuation included) sit
-- closer than 11.9 dark / 7.6 light. Supporting colors (comments, calls,
-- operators) sit a step lower in lightness so the accents lead.
-- The grays are neutral, in roughly even lightness steps, like the text.
--
-- Both variants share one set of keys, so lua/gruber-modern/groups.lua
-- and lua/theme-palette.lua never branch on the background. The gruber-darker
-- names (bg+1, niagara, wisteria...) keep their meaning as steps away from
-- the background, not as literal colors: in `light`, bg+1 is darker than bg.
--
-- Contrast on bg (WCAG 2.x), dark / light:
--   fg 14.8 / 16.7, every syntax role >= 7.0 (AAA) on both, inlay hints
--   (fg-2) 5.0 / 5.0, line numbers (bg+4) 3.3 / 3.6 (UI, 3:1 minimum).
--   Inside a Visual selection every syntax role stays >= 4.5 (AA).
--   Comments 7.2 / 7.1, parameters 11.0 / 10.5; plain text on a search match
--   7.6 / 10.3.
local M = {}

M.dark = {
  -- gruber-darker's own #181818: near-black enough for 14.8:1 text, lifted
  -- enough that the bright accents don't halate as they do on #101010.
  -- Floats sit one step darker; the steps above keep their old separation.
  ["bg-1"] = "#101010",
  bg = "#181818",
  ["bg+1"] = "#2C2C2C",
  ["bg+2"] = "#3D3D3D",
  ["bg+3"] = "#4F4F4F",
  ["bg+4"] = "#6A6A6A",
  fg = "#EAEAEA",
  ["fg+1"] = "#F4F4FF",
  ["fg+2"] = "#F5F5F5",
  white = "#FFFFFF",
  black = "#000000",
  ["red-1"] = "#D9353C",
  red = "#FF4D55",
  -- Lifted from #FF6468 so error text reaches 7:1 on bg.
  ["red+1"] = "#FF7B7E",
  green = "#74DB4A",
  yellow = "#FBDA1B",
  brown = "#EB9E45",
  quartz = "#86CCAC",
  ["niagara-2"] = "#34437A",
  ["niagara-1"] = "#5E6B89",
  niagara = "#88B2FF",
  wisteria = "#DA9EFE",
  -- Syntax roles. Functions are slate: a clear sky blue (OKLCH 0.75 /
  -- 0.13 / 258), saturated enough that calls never read as gray punctuation
  -- or as the cyan literals, at 7.9:1; purple is a true violet (312) so it
  -- splits cleanly from both the blue calls and the pink operators, which
  -- also serve as the terminal's magenta.
  slate = "#7AAFFE",
  purple = "#DA9EFE",
  rose = "#FF7CAD",
  -- Neon keeps its hue but stays at 0.22 chroma: at the sRGB edge (0.27)
  -- strings glowed louder than every other role.
  neon = "#6EF362",
  -- Constants and literals: a clean cyan (OKLCH 0.82 / 0.13 / 196), far
  -- enough from green to never read as a dim neon string or the quartz hint,
  -- and chroma enough to never blur into the blue calls.
  aqua = "#35DEDF",
  -- Dimmed text (inactive windows, picker details, punctuation) and
  -- faint annotations (inlay hints).
  ["fg-1"] = "#A6A6A6",
  ["fg-2"] = "#888888",
  -- The loudest text: function definitions.
  strong = "#FFFFFF",
  -- Visual selection: a slate-tinted step instead of bg+3, which dropped
  -- comments to 3.7:1 and dimmed text to 3.4:1 inside a selection.
  visual = "#2C3650",
  -- Comments: amber (OKLCH 0.73 / 0.125 / 62), clearly orange next to the
  -- yellow keywords and darker than them, so long comment blocks stay
  -- readable (7.2:1) without competing with the code.
  comment = "#DF954E",
  -- Parameters: a pale salmon (OKLCH 0.85 / 0.08 / 32), light like a name
  -- but with a warm pink cast nothing else uses, so they stand apart from
  -- locals, comments and keywords at a glance.
  param = "#FFBBAC",
  -- Search matches: yellow at 25% over bg, the same family as IncSearch and
  -- a different hue from the slate Visual, so a match inside a selection
  -- still shows.
  search = "#51481A",
  -- Terminal-only: cyan and the bright variants.
  teal = "#5CE4D5",
  ["yellow+1"] = "#FBEA8A",
  ["rose+1"] = "#FFA0C0",
  ["neon+1"] = "#95FD8A",
  ["purple+1"] = "#E3B6FF",
  ["teal+1"] = "#88F1E3",
}

-- The same hues on warm paper, each darkened to at least 7:1 on bg. Paper
-- can't show yellow at that contrast, so keywords go to a deep olive and
-- parameters to an oxblood, a step darker than the rest, to keep them off
-- the amber comments; comments turn a little more orange (55) for the
-- same reason.
M.light = {
  ["bg-1"] = "#F2F0EB",
  bg = "#FBFAF7",
  ["bg+1"] = "#ECEAE4",
  ["bg+2"] = "#DEDBD3",
  ["bg+3"] = "#CAC6BC",
  ["bg+4"] = "#85837D",
  fg = "#1A1A1A",
  ["fg+1"] = "#0F0F14",
  ["fg+2"] = "#0A0A0A",
  white = "#FFFFFF",
  black = "#000000",
  ["red-1"] = "#8E0F18",
  red = "#C4202B",
  ["red+1"] = "#AC131E",
  green = "#0C6504",
  yellow = "#584A01",
  brown = "#874300",
  quartz = "#3F6E5A",
  ["niagara-2"] = "#BBCBF0",
  ["niagara-1"] = "#5A6683",
  niagara = "#2F5BB0",
  wisteria = "#742E97",
  slate = "#294793",
  purple = "#742E97",
  rose = "#9B1958",
  neon = "#0C6504",
  aqua = "#025D6B",
  ["fg-1"] = "#535353",
  ["fg-2"] = "#6D6D6D",
  strong = "#000000",
  visual = "#D6DEEF",
  comment = "#874300",
  param = "#6B2527",
  search = "#CFC7AD",
  teal = "#00706A",
  ["yellow+1"] = "#7D6200",
  ["rose+1"] = "#B3346B",
  ["neon+1"] = "#237A17",
  ["purple+1"] = "#8B40B2",
  ["teal+1"] = "#008A82",
}

--- The variant for `background` ("dark" or "light"), defaulting to 'background'.
function M.get(background)
  return M[background or vim.o.background] or M.dark
end

return M
