vim.cmd('packadd nvim-notify')

require("notify").setup({
  stages = "fade",               -- Simple fade is cleaner than sliding animations
  timeout = 3500,                -- Shorter timeout for a cleaner feel
  render = "compact",            -- Removes borders and titles for a sleek look
  background_colour = "#121212", -- Match this to your terminal bg
  fps = 60
})

vim.notify = require("notify")
