local c = require "theme-palette"

local function recording()
  local reg = vim.fn.reg_recording()
  if reg == "" then
    return ""
  end
  return " @" .. reg
end

local function wide()
  return vim.o.columns >= 110
end

local theme = {
  normal = {
    a = { bg = c.accent, fg = c.bg_statusline, gui = "bold" },
    b = { bg = c.bg_statusline, fg = c.fg_dark },
    c = { bg = c.bg_statusline, fg = c.fg_dark },
  },
  insert = { a = { bg = c.green, fg = c.bg_statusline, gui = "bold" } },
  visual = { a = { bg = c.purple, fg = c.bg_statusline, gui = "bold" } },
  replace = { a = { bg = c.red, fg = c.bg_statusline, gui = "bold" } },
  command = { a = { bg = c.orange, fg = c.bg_statusline, gui = "bold" } },
  terminal = { a = { bg = c.green, fg = c.bg_statusline, gui = "bold" } },
  inactive = {
    a = { bg = c.bg_statusline, fg = c.fg_dark },
    b = { bg = c.bg_statusline, fg = c.fg_dark },
    c = { bg = c.bg_statusline, fg = c.fg_dark },
  },
}

require("lualine").setup {
  options = {
    theme = theme,
    globalstatus = true,
    section_separators = "",
    component_separators = "",
    disabled_filetypes = { statusline = { "starter", "ministarter" } },
  },
  sections = {
    lualine_a = { { "mode", separator = { right = "" }, padding = { left = 2, right = 1 } } },
    lualine_b = {
      { "branch", icon = "", cond = wide },
      {
        "diff",
        symbols = { added = "+", modified = "~", removed = "−" },
        diff_color = { added = { fg = c.git_add }, modified = { fg = c.git_change }, removed = { fg = c.red } },
        cond = wide,
      },
    },
    lualine_c = {
      {
        "filename",
        path = 1,
        symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]" },
        color = { fg = c.fg },
      },
      {
        "diagnostics",
        symbols = { error = "● ", warn = "▲ ", info = "◆ ", hint = "◇ " },
        diagnostics_color = {
          error = { fg = c.red },
          warn = { fg = c.warning },
          info = { fg = c.info },
          hint = { fg = c.hint },
        },
      },
    },
    lualine_x = {
      { recording, color = { fg = c.red, gui = "bold" } },
      {
        "encoding",
        cond = function()
          return vim.bo.fileencoding ~= "" and vim.bo.fileencoding ~= "utf-8"
        end,
      },
      {
        "fileformat",
        cond = function()
          return vim.bo.fileformat ~= "unix"
        end,
      },
      { "filetype", icons_enabled = false, colored = false, cond = wide },
    },
    lualine_y = { { "progress", color = { fg = c.fg_dark, bg = c.bg_statusline } } },
    lualine_z = { { "location", color = { fg = c.fg, bg = c.bg_statusline }, padding = { left = 1, right = 2 } } },
  },
  tabline = {
    lualine_a = {
      {
        "buffers",
        icons_enabled = false,
        symbols = { modified = " ●" },
        separator = "",
        section_separators = { left = "", right = "" },
        buffers_color = {
          active = { fg = c.accent, bg = c.bg_float, gui = "bold" },
          inactive = { fg = c.fg_dark, bg = c.bg_statusline },
        },
        fmt = function(name, ctx)
          if not ctx.file or ctx.file == "" or ctx.buftype ~= "" then
            return name
          end
          local icon = require("mini.icons").get("file", ctx.file)
          return icon .. "  " .. name
        end,
      },
    },
    lualine_z = {
      {
        function()
          return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        end,
        icon = "",
      },
    },
  },
}
