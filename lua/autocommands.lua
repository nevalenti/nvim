local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local text_yank_group = augroup("TextYank", { clear = true })
local buf_write_pre_group = augroup("BufWritePreGroup", { clear = true })

autocmd("TextYankPost", {
  group = text_yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "IncSearch",
      timeout = 250,
    }
  end,
})

autocmd("BufWritePre", {
  group = buf_write_pre_group,
  pattern = "*",
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if vim.bo.filetype ~= "oil" and not bufname:match("^oil://") then
      vim.cmd([[%s/\s\+$//e]])
    end
  end,
})
