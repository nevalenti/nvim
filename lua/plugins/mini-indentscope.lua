require("mini.indentscope").setup {
  symbol = "│",
  draw = { delay = 30 },
  options = { try_as_border = true },
}

vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = require("cyberdream.colors").default.grey })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "trouble", "lazy", "mason", "notify", "oil", "qf", "checkhealth", "starter" },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

vim.api.nvim_create_autocmd("WinEnter", {
  callback = function()
    if vim.api.nvim_win_get_config(0).relative ~= "" then
      vim.b.miniindentscope_disable = true
    end
  end,
})
