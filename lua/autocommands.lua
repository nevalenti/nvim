local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local text_yank_group = augroup("TextYank", { clear = true })
local buf_write_pre_group = augroup("BufWritePreGroup", { clear = true })

autocmd("TextYankPost", {
  group = text_yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 250 }
  end,
})

autocmd("BufWritePre", {
  group = buf_write_pre_group,
  pattern = "*",
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if vim.bo.filetype ~= "oil" and not bufname:match "^oil://" then
      vim.cmd [[%s/\s\+$//e]]
    end
  end,
})

vim.api.nvim_create_user_command("Reg", function()
  local Popup = require "nui.popup"

  local raw_registers = vim.fn.execute "reg"
  local lines = vim.split(vim.trim(raw_registers), "\n", { trimempty = true })

  local popup = Popup {
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
      text = { top = " Registers ", top_align = "center" },
    },
    position = "50%",
    size = { width = "70%", height = "50%" },
    win_options = {
      number = true,
      relativenumber = true,
      cursorline = true,
    },
  }

  popup:mount()

  vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, lines)
  vim.bo[popup.bufnr].modifiable = false
  vim.bo[popup.bufnr].buftype = "nofile"

  popup:map("n", "q", function()
    popup:unmount()
  end)

  popup:map("n", "<CR>", function()
    local line = vim.api.nvim_get_current_line()
    local reg_name = line:match '^%s*"(.)'

    if reg_name then
      popup:unmount()
      vim.cmd('normal! "' .. reg_name .. "p")
    end
  end)
end, {})

vim.api.nvim_create_user_command("Pwd", function()
  local Popup = require "nui.popup"
  local raw_output = vim.fn.execute "pwd"
  local cleaned_output = vim.trim(raw_output)

  local popup = Popup {
    enter = true,
    focusable = true,
    border = { style = "rounded", text = { top = "Working Directory", top_align = "center" } },
    position = "50%",
    size = { width = "70%", height = "10%" },
  }

  popup:mount()

  local lines = vim.split(cleaned_output, "\n", { trimempty = true })
  vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, lines)

  vim.bo[popup.bufnr].modifiable = false
  vim.bo[popup.bufnr].buftype = "nofile"

  popup:map("n", "q", function()
    popup:unmount()
  end)
end, {})

vim.api.nvim_create_user_command("Buf", function()
  local Popup = require "nui.popup"

  local raw_buffers = vim.fn.execute "ls"
  local lines = vim.split(vim.trim(raw_buffers), "\n", { trimempty = true })

  local popup = Popup {
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
      text = { top = " Buffers ", top_align = "center" },
    },
    position = "50%",
    size = { width = "70%", height = "50%" },
    win_options = {
      number = true,
      relativenumber = true,
      cursorline = true,
    },
  }

  popup:mount()

  vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, lines)
  vim.bo[popup.bufnr].modifiable = false
  vim.bo[popup.bufnr].buftype = "nofile"

  popup:map("n", "q", function()
    popup:unmount()
  end)

  popup:map("n", "<CR>", function()
    local line = vim.api.nvim_get_current_line()
    local bufnr = line:match "^%s*(%d+)"

    if bufnr then
      popup:unmount()
      vim.api.nvim_set_current_buf(tonumber(bufnr))
    end
  end)
end, {})
