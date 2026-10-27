-- Keeps Waybar, Rofi, swaync and btop on Neovim's colorscheme: each app has
-- a template next to its config with {{role}} placeholders ({{role_rgb}} for
-- rgba()), rendered from theme-palette whenever the colorscheme changes.
local M = {}

local config = vim.fn.expand "~/.config/"

local waybar = { "pkill", "-SIGUSR2", "-x", "waybar" }
local targets = {
  { template = "waybar/style.css.tmpl", output = "waybar/style.css", reload = waybar },
  { template = "waybar/config.jsonc.tmpl", output = "waybar/config.jsonc", reload = waybar },
  { template = "swaync/style.css.tmpl", output = "swaync/style.css", reload = { "swaync-client", "-rs" } },
  -- Rofi and btop read their theme when they start.
  { template = "rofi/nvim.rasi.tmpl", output = "rofi/nvim.rasi" },
  { template = "btop/themes/nvim.theme.tmpl", output = "btop/themes/nvim.theme" },
}

local function roles(c)
  local t = c.terminal or {}
  return {
    bg = c.bg,
    surface = c.hover_bg,
    hover = c.selection,
    sel = c.popup_selection,
    border = c.border,
    fg = c.fg,
    fg_dark = c.fg_dark,
    muted = c.inlay_hint or c.fg_dark,
    gray = c.gray,
    accent = c.accent,
    green = c.green,
    green_bright = t[11] or c.green,
    red = t[2] or c.red,
    orange = c.orange,
    func = c.func,
    type = c.type,
    type_bright = t[13] or c.type,
    blue = c.blue,
  }
end

local function read(path)
  local file = io.open(path)
  if not file then
    return nil
  end
  local text = file:read "*a"
  file:close()
  return text
end

local function render(text, values)
  return (
    text:gsub("{{([%w_]+)}}", function(name)
      local rgb = name:match "^(.-)_rgb$"
      local hex = values[rgb or name]
      if not hex then
        return nil
      end
      if not rgb then
        return hex
      end
      local r, g, b = hex:match "#(%x%x)(%x%x)(%x%x)"
      return ("%d, %d, %d"):format(tonumber(r, 16), tonumber(g, 16), tonumber(b, 16))
    end)
  )
end

function M.sync(c)
  local values = roles(c)
  values.colors_name = vim.g.colors_name
  for name, hex in pairs(values) do
    values[name] = name == "colors_name" and hex or hex:upper()
  end

  -- Only rewrite what changed, and reload each app once.
  local reloads = {}
  for _, target in ipairs(targets) do
    local template = read(config .. target.template)
    if template then
      local text = render(template, values)
      local path = config .. target.output
      if text ~= read(path) then
        local file = io.open(path, "w")
        if file then
          file:write(text)
          file:close()
          if target.reload then
            reloads[table.concat(target.reload, " ")] = target.reload
          end
        end
      end
    end
  end
  for _, command in pairs(reloads) do
    pcall(vim.system, command)
  end
end

return M
