local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local text_yank_group = augroup("TextYank", { clear = true })
local buf_write_pre_group = augroup("BufWritePreGroup", { clear = true })
local checktime_group = augroup("CheckTime", { clear = true })
local last_place_group = augroup("LastPlace", { clear = true })

autocmd("TextYankPost", {
  group = text_yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "YankHighlight", timeout = 250 }
  end,
})

autocmd("BufWritePre", {
  group = buf_write_pre_group,
  pattern = "*",
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if vim.bo.filetype ~= "oil" and not bufname:match "^oil://" then
      local pos = vim.api.nvim_win_get_cursor(0)
      vim.cmd [[keeppatterns %s/\s\+$//e]]
      pcall(vim.api.nvim_win_set_cursor, 0, pos)
    end
  end,
})

autocmd("BufWritePre", {
  group = buf_write_pre_group,
  pattern = "*",
  callback = function()
    local dir = vim.fn.expand "<afile>:p:h"
    if dir:match "^%a+://" then
      return
    end
    vim.fn.mkdir(dir, "p")
  end,
})

autocmd({ "FocusGained", "BufEnter" }, {
  group = checktime_group,
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "" then
      vim.cmd.checktime()
    end
  end,
})

autocmd("BufReadPost", {
  group = last_place_group,
  pattern = "*",
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

local function show_popup(title, lines, selectable)
  local Popup = require "nui.popup"
  local event = require("nui.utils.autocmd").event

  local width = vim.fn.strdisplaywidth(title) + 2
  for _, line in ipairs(lines) do
    width = math.max(width, vim.fn.strdisplaywidth(line) + 2)
  end

  local popup = Popup {
    enter = true,
    focusable = true,
    relative = "editor",
    border = { style = "rounded", text = { top = title, top_align = "center" } },
    position = "50%",
    size = {
      width = math.min(math.max(width, 20), math.max(1, vim.o.columns - 4)),
      height = math.min(math.max(#lines, 1), math.max(1, math.floor(vim.o.lines * 0.6))),
    },
    win_options = {
      number = false,
      relativenumber = false,
      cursorline = selectable,
      signcolumn = "no",
      wrap = false,
    },
  }

  popup:mount()
  vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, lines)
  vim.bo[popup.bufnr].modifiable = false
  vim.bo[popup.bufnr].buftype = "nofile"

  local closing = false
  local function close()
    if closing then
      return
    end
    closing = true
    popup:unmount()
  end

  popup:map("n", "q", close)
  popup:map("n", "<Esc>", close)
  popup:on(event.BufLeave, close, { once = true })

  return popup, close
end

vim.api.nvim_create_user_command("Reg", function()
  local raw_registers = vim.fn.execute "reg"
  local lines = vim.split(vim.trim(raw_registers), "\n", { trimempty = true })
  local popup, close = show_popup(" Registers ", lines, true)

  popup:map("n", "<CR>", function()
    local line = vim.api.nvim_get_current_line()
    local reg_name = line:match '^%s*%S+%s+"(.)'

    if reg_name then
      close()
      vim.cmd('normal! "' .. reg_name .. "p")
    end
  end)
end, {})

vim.api.nvim_create_user_command("Pwd", function()
  show_popup(" Working Directory ", { vim.fn.getcwd() }, false)
end, {})

vim.api.nvim_create_user_command("Buf", function()
  local raw_buffers = vim.fn.execute "ls"
  local lines = vim.split(vim.trim(raw_buffers), "\n", { trimempty = true })
  local popup, close = show_popup(" Buffers ", lines, true)

  popup:map("n", "<CR>", function()
    local line = vim.api.nvim_get_current_line()
    local bufnr = line:match "^%s*(%d+)"

    if bufnr then
      close()
      vim.api.nvim_set_current_buf(tonumber(bufnr))
    end
  end)
end, {})
