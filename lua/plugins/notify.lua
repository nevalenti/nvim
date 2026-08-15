require("notify").setup {
  stages = "fade",
  timeout = 3500,
  render = "compact",
  background_colour = require("vscode.colors").get_colors().vscBack,
  fps = 60,
}
