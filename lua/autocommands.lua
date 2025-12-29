local progress                   = require("fidget.progress")

local augroup                    = vim.api.nvim_create_augroup
local autocmd                    = vim.api.nvim_create_autocmd

local text_yank_group            = augroup("TextYank", { clear = true })
local buf_write_pre_group        = augroup("BufWritePreGroup", { clear = true })
local codecompanion_group        = augroup("CodeCompanionMarkdown", { clear = true })
local codecompanion_fidget_group = augroup("CodeCompanionFidget", {})

local handles                    = {}

autocmd({ "FileType", "BufEnter", "BufWinEnter" }, {
  group = codecompanion_group,
  pattern = "*.codecompanion",
  callback = function(ev)
    local buf = ev.buf

    vim.bo[buf].filetype = "markdown"
    vim.bo[buf].syntax = "markdown"

    pcall(vim.treesitter.start, buf, "markdown")
    pcall(vim.treesitter.start, buf, "markdown_inline")

    vim.wo.conceallevel = 3
    vim.wo.concealcursor = "nvic"
  end,
})

autocmd({ "FileType", "BufEnter" }, {
  group = codecompanion_group,
  pattern = "codecompanion",
  callback = function(ev)
    local buf = ev.buf

    vim.bo[buf].filetype = "markdown"
    vim.bo[buf].syntax = "markdown"

    pcall(vim.treesitter.start, buf, "markdown")
    pcall(vim.treesitter.start, buf, "markdown_inline")

    vim.wo.conceallevel = 3
    vim.wo.concealcursor = "nvic"
  end,
})

autocmd("User", {
  pattern = "CodeCompanionRequestStarted",
  group = codecompanion_fidget_group,
  callback = function(e)
    handles[e.data.id] = progress.handle.create({
      title = "CodeCompanion",
      message = "Thinking...",
      lsp_client = { name = e.data.adapter.formatted_name },
    })
  end,
})

autocmd("User", {
  pattern = "CodeCompanionRequestFinished",
  group = codecompanion_fidget_group,
  callback = function(e)
    local h = handles[e.data.id]
    if h then
      h.message = e.data.status == "success" and "Done" or "Failed"
      h:finish()
      handles[e.data.id] = nil
    end
  end,
})

autocmd("TextYankPost", {
  group = text_yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
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
