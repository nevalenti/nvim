require("notify").setup {
  stages = "fade",
  timeout = 3500,
  render = "compact",
  background_colour = function()
    return require("theme-palette").bg
  end,
  fps = 60,
}
