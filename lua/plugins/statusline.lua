local palette = require("vscode.colors").get_colors()

local function recording()
  local reg = vim.fn.reg_recording()
  if reg == "" then
    return ""
  end
  return " @" .. reg
end

require("lualine").setup {
  options = {
    theme = "vscode",
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = {
      {
        "filename",
        path = 1,
        symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]", newfile = "[New]" },
      },
      "diagnostics",
    },
    lualine_x = {
      { recording, color = { fg = palette.vscRed, gui = "bold" } },
      "searchcount",
      "selectioncount",
      "lsp_status",
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
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  tabline = {
    lualine_a = {
      {
        "buffers",
        icons_enabled = false,
        symbols = { modified = " ●" },
        buffers_color = {
          active = { fg = palette.vscFront, bg = palette.vscLeftMid, gui = "bold" },
          inactive = { fg = palette.vscGray, bg = palette.vscLeftDark },
        },
        fmt = function(name, ctx)
          local icon = require("mini.icons").get("file", ctx.file)
          return icon .. "  " .. name
        end,
      },
    },
    lualine_z = {
      {
        function()
          return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
        end,
        icon = "",
      },
    },
  },
}
