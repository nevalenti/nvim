require("twilight").setup {
  dimming = { alpha = 0.35 },
  context = 12,
}

require("zen-mode").setup {
  window = {
    backdrop = 0.95,
    width = 0.85,
    options = {
      number = false,
      relativenumber = false,
      signcolumn = "no",
    },
  },
  plugins = {
    twilight = { enabled = true },
    gitsigns = { enabled = true },
    tmux = { enabled = false },
  },
}

vim.keymap.set("n", "<leader>zz", function()
  require("zen-mode").toggle()
end, { desc = "Toggle zen mode" })
