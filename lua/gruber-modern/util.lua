local M = {}

local function rgb(hex)
  return tonumber(hex:sub(2, 3), 16), tonumber(hex:sub(4, 5), 16), tonumber(hex:sub(6, 7), 16)
end

--- `fg` laid over `bg` at `alpha` (0..1), for tinted backgrounds that keep
--- the text on them readable.
function M.blend(fg, bg, alpha)
  local fr, fg_, fb = rgb(fg)
  local br, bg_, bb = rgb(bg)
  local function mix(a, b)
    return math.floor(a * alpha + b * (1 - alpha) + 0.5)
  end
  return ("#%02X%02X%02X"):format(mix(fr, br), mix(fg_, bg_), mix(fb, bb))
end

return M
