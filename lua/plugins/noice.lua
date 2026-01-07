vim.cmd "packadd nui.nvim"
vim.cmd "packadd nvim-notify"
vim.cmd "packadd noice.nvim"

require("noice").setup {
  lsp = {
    progress = {
      enabled = true,
      format = "lsp_progress",
      format_done = "lsp_progress_done",
      throttle = 1000 / 30,
    },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    hover = {
      enabled = true,
      silent = true,
    },
  },

  routes = {
    {
      filter = { event = "msg_show", min_height = 20 },
      view = "split",
    },
  },

  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = true,
    lsp_doc_border = true,
  },

  views = {
    cmdline_popup = {
      position = { row = "30%", col = "50%" },
      size = { width = 60, height = "auto" },
      border = { style = "rounded" },
    },
    hover = {
      border = { style = "rounded" },
      position = { row = 2, col = 2 },
    },
  },
}
