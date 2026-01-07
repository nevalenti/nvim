vim.cmd('packadd nvim-notify')

require("notify").setup({
  stages = "fade",
  timeout = 3500,
  render = "compact",
  background_colour = "#121212",
  fps = 60
})

vim.notify = require("notify")
