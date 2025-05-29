require('trouble').setup {
  use_diagnostic_signs = true,
}

local map = vim.keymap.set

map("n", "<leader>tt", "<CMD>Trouble diagnostics toggle<CR>", { desc = "Toggle Trouble" })
map("n", "[t", function()
  require("trouble").next({ skip_groups = true, jump = true });
end)
map("n", "]t", function()
  require("trouble").previous({ skip_groups = true, jump = true });
end)

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = 'E',
      [vim.diagnostic.severity.WARN] = 'W',
      [vim.diagnostic.severity.HINT] = 'H',
      [vim.diagnostic.severity.INFO] = 'I',
    },
    active = true,
    priority = 20,
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    header = "",
    prefix = "",
  },
})
