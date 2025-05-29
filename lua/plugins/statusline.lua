local theme = {
  normal = {
    a = { fg = '#E4E4E4', bg = '#9F84FF', gui = 'bold' },
    b = { fg = '#E4E4E4', bg = '#453D41' },
    c = { fg = '#E4E4E4', bg = '#121212' },
  },
  insert = {
    a = { fg = '#121212', bg = '#73D936', gui = 'bold' },
    b = { fg = '#E4E4E4', bg = '#453D41' },
    c = { fg = '#E4E4E4', bg = '#121212' },
  },
  visual = {
    a = { fg = '#121212', bg = '#FFDD33', gui = 'bold' },
    b = { fg = '#E4E4E4', bg = '#453D41' },
    c = { fg = '#E4E4E4', bg = '#121212' },
  },
  replace = {
    a = { fg = '#121212', bg = '#F43841', gui = 'bold' },
    b = { fg = '#E4E4E4', bg = '#453D41' },
    c = { fg = '#E4E4E4', bg = '#121212' },
  },
  command = {
    a = { fg = '#121212', bg = '#B584FF', gui = 'bold' },
    b = { fg = '#E4E4E4', bg = '#453D41' },
    c = { fg = '#E4E4E4', bg = '#121212' },
  },
  inactive = {
    a = { fg = '#E4E4E4', bg = '#101010', gui = 'bold' },
    b = { fg = '#E4E4E4', bg = '#101010' },
    c = { fg = '#E4E4E4', bg = '#101010' },
  },
}

require('lualine').setup {
  options = { theme = theme },
}
