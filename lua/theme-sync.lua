-- Keeps Waybar, Rofi, swaync, btop, Hyprland, hyprlock, Alacritty, tmux,
-- VS Code and zsh (with its p10k prompt) on Neovim's colorscheme: each app has a template
-- next to its config with {{role}} placeholders ({{role_rgb}} for rgba(),
-- {{role_hex}} for a bare RRGGBB, {{role_ansi}} for an R;G;B escape),
-- rendered from theme-palette whenever the colorscheme changes.
local M = {}

local home = vim.fn.expand "~/"

local waybar = { "pkill", "-SIGUSR2", "-x", "waybar" }
local targets = {
  { template = ".config/waybar/style.css.tmpl", output = ".config/waybar/style.css", reload = waybar },
  { template = ".config/waybar/config.jsonc.tmpl", output = ".config/waybar/config.jsonc", reload = waybar },
  {
    template = ".config/swaync/style.css.tmpl",
    output = ".config/swaync/style.css",
    reload = { "swaync-client", "-rs" },
  },
  -- hyprland.lua loads colors.lua for its borders and background.
  { template = ".config/hypr/colors.lua.tmpl", output = ".config/hypr/colors.lua", reload = { "hyprctl", "reload" } },
  -- tmux sources theme.conf from ~/.tmux.conf; running servers pick it up here.
  { template = ".tmux/theme.conf.tmpl", output = ".tmux/theme.conf", reload = { "tmux", "source-file", home .. ".tmux/theme.conf" } },
  -- Alacritty imports nvim.toml and reloads it on its own.
  { template = ".config/alacritty/nvim.toml.tmpl", output = ".config/alacritty/nvim.toml" },
  -- Rofi, btop, hyprlock and zsh read their theme when they start.
  { template = ".config/rofi/nvim.rasi.tmpl", output = ".config/rofi/nvim.rasi" },
  { template = ".config/btop/themes/nvim.theme.tmpl", output = ".config/btop/themes/nvim.theme" },
  { template = ".config/hypr/hyprlock.conf.tmpl", output = ".config/hypr/hyprlock.conf" },
  { template = ".config/zsh/theme.zsh.tmpl", output = ".config/zsh/theme.zsh" },
  { template = ".p10k.zsh.tmpl", output = ".p10k.zsh" },
  -- The "Neovim" color theme in the local Gruber Darker extension; VS Code
  -- picks it up on its next window reload.
  {
    template = ".vscode/extensions/nevalenti.gruber-darker-theme-1.0.0/themes/nvim-color-theme.json.tmpl",
    output = ".vscode/extensions/nevalenti.gruber-darker-theme-1.0.0/themes/nvim-color-theme.json",
  },
}

local function roles(c)
  local t = c.terminal or {}
  local values = {
    bg = c.bg,
    float = c.bg_float or c.bg,
    surface = c.hover_bg,
    hover = c.selection,
    sel = c.popup_selection,
    border = c.border,
    fg = c.fg,
    fg_dark = c.fg_dark,
    muted = c.inlay_hint or c.fg_dark,
    line_number = c.line_number or c.gray,
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
    bright = c.current_line_number or c.fg,
    fg_bright = t[16] or c.fg,
    caret = c.caret,
    visual = c.visual or c.selection,
    search = c.search_bg,
    string = c.string,
    constant = c.constant,
    operator = c.operator,
    comment = c.comment,
    param = c.parameter,
    error = c.red,
    warning = c.warning,
    info = c.info or c.blue,
    hint = c.hint or c.green,
  }
  for index = 1, 16 do
    values["t" .. (index - 1)] = t[index]
  end
  return values
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
      local role, format = name:match "^(.-)_(%l+)$"
      if not (format == "rgb" or format == "hex" or format == "ansi") then
        role, format = name, nil
      end
      local hex = values[role]
      if not hex then
        return nil
      end
      if not format then
        return hex
      end
      if format == "hex" then
        return hex:sub(2)
      end
      local r, g, b = hex:match "#(%x%x)(%x%x)(%x%x)"
      local separator = format == "rgb" and ", " or ";"
      return table.concat({ tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }, separator)
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
    local template = read(home .. target.template)
    if template then
      local text = render(template, values)
      local path = home .. target.output
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
