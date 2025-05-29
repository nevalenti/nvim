return {
  {
    'kevinhwang91/rnvimr',
    lazy = false,
    config = function()
      vim.g.rnvimr_enable_ex = 1
      vim.g.rnvimr_enable_picker = 1
      vim.g.rnvimr_layout = {
        relative = 'editor',
        width = vim.o.columns,
        height = vim.o.lines - 2,
        col = 0,
        row = 0,
        style = 'minimal',
      }
    end,
  },
}
