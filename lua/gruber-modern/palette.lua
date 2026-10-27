-- Gruber Modern: gruber-darker.nvim's backgrounds, grays and hues, with the
-- accents rebuilt in OKLCH around the neon green. Yellow matches its
-- lightness and saturation; purple leans a little violet, the only way a
-- purple gets that bright without turning pastel. Supporting colors (amber
-- comments, slate calls, rose) sit a step lower so the accents lead.
-- The keys after `wisteria` are this theme's own; gruber-darker.nvim ignores
-- names it doesn't define.
return {
  ["bg-1"] = "#0C0C0C",
  bg = "#101010",
  ["bg+1"] = "#282828",
  ["bg+2"] = "#4D4448",
  ["bg+3"] = "#4F4F4F",
  ["bg+4"] = "#665C61",
  fg = "#EAEAEA",
  ["fg+1"] = "#F4F4FF",
  ["fg+2"] = "#F5F5F5",
  white = "#FFFFFF",
  black = "#000000",
  ["red-1"] = "#D9353C",
  red = "#FF4D55",
  ["red+1"] = "#FF6468",
  green = "#74DB4A",
  yellow = "#FAD821",
  brown = "#EB9E45",
  quartz = "#86CCAC",
  ["niagara-2"] = "#34437A",
  ["niagara-1"] = "#5E6B89",
  niagara = "#88B2FF",
  wisteria = "#DBABFF",
  -- Syntax roles; colors/gruber-modern.lua puts them in gruber-darker's
  -- function (niagara), string (green) and type (quartz) slots; types are
  -- purple and rose is kept for the terminal's magenta. Functions
  -- are slate: niagara-1's hue, lifted to read at 8.5:1 on the background.
  slate = "#9DB0DA",
  purple = "#DBABFF",
  rose = "#F589B6",
  neon = "#47FD38",
  -- Dimmed text (inactive windows, picker details, punctuation) and
  -- faint annotations (inlay hints).
  ["fg-1"] = "#A6A6A6",
  ["fg-2"] = "#888888",
  -- Terminal-only: cyan and the bright variants.
  teal = "#5CE4D5",
  ["yellow+1"] = "#FBEA8A",
  ["rose+1"] = "#FDA6C8",
  ["neon+1"] = "#86FF78",
  ["purple+1"] = "#DFB8FC",
  ["teal+1"] = "#88F1E3",
}
