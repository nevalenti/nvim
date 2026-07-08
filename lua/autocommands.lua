local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local text_yank_group = augroup("TextYank", { clear = true })
local buf_write_pre_group = augroup("BufWritePreGroup", { clear = true })

autocmd("TextYankPost", {
  group = text_yank_group,
  pattern = "*",
  callback = function()
    vim.hl.hl_op { higroup = "IncSearch", timeout = 250 }
  end,
})

autocmd("BufWritePre", {
  group = buf_write_pre_group,
  pattern = "*",
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if vim.bo.modifiable and vim.bo.filetype ~= "oil" and not bufname:match "^oil://" then
      local pos = vim.api.nvim_win_get_cursor(0)
      vim.cmd [[keeppatterns %s/\s\+$//e]]
      pcall(vim.api.nvim_win_set_cursor, 0, pos)
    end
  end,
})

local function ex_output_popup(opts)
  local Popup = require "nui.popup"

  local lines = vim.split(vim.trim(vim.fn.execute(opts.ex_cmd)), "\n", { trimempty = true })

  local popup = Popup {
    enter = true,
    focusable = true,
    border = { style = "rounded", text = { top = opts.title, top_align = "center" } },
    position = "50%",
    size = opts.size,
    win_options = opts.win_options,
  }

  popup:mount()

  vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, lines)
  vim.bo[popup.bufnr].modifiable = false
  vim.bo[popup.bufnr].buftype = "nofile"

  popup:map("n", "q", function()
    popup:unmount()
  end)

  if opts.on_select then
    popup:map("n", "<CR>", function()
      local line = vim.api.nvim_get_current_line()
      local match = line:match(opts.select_pattern)
      if match then
        popup:unmount()
        opts.on_select(match)
      end
    end)
  end
end

vim.api.nvim_create_user_command("Reg", function()
  ex_output_popup {
    ex_cmd = "reg",
    title = " Registers ",
    size = { width = "70%", height = "50%" },
    win_options = { number = true, relativenumber = true, cursorline = true },
    select_pattern = '^%s*"(.)',
    on_select = function(reg_name)
      vim.cmd('normal! "' .. reg_name .. "p")
    end,
  }
end, {})

vim.api.nvim_create_user_command("Pwd", function()
  ex_output_popup {
    ex_cmd = "pwd",
    title = "Working Directory",
    size = { width = "70%", height = "10%" },
  }
end, {})

vim.api.nvim_create_user_command("Buf", function()
  ex_output_popup {
    ex_cmd = "ls",
    title = " Buffers ",
    size = { width = "70%", height = "50%" },
    win_options = { number = true, relativenumber = true, cursorline = true },
    select_pattern = "^%s*(%d+)",
    on_select = function(bufnr)
      vim.api.nvim_set_current_buf(tonumber(bufnr))
    end,
  }
end, {})
