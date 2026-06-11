local actions = require "telescope.actions"
local lga_actions = require "telescope-live-grep-args.actions"

require("telescope").setup {
  extensions = {
    live_grep_args = {
      mappings = {
        i = {
          ["<C-t>"] = lga_actions.quote_prompt { postfix = " -t " },
        },
      },
    },
  },
  defaults = {
    mappings = {
      i = {
        ["<leader>q"] = actions.close,
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
        ["<C-d>"] = "preview_scrolling_down",
        ["<C-u>"] = "preview_scrolling_up",
      },
      n = {
        ["<leader>q"] = actions.close,
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
        ["<C-d>"] = "preview_scrolling_down",
        ["<C-u>"] = "preview_scrolling_up",
      },
    },
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        mirror = true,
        prompt_position = "top",
        width = 0.8,
        height = 0.9,
        preview_height = 0.6,
      },
      horizontal = {
        prompt_position = "top",
        width = 0.8,
        height = 0.8,
        preview_width = 0.5,
      },
    },
  },
}
require("telescope").load_extension "fzf"
require("telescope").load_extension "live_grep_args"

local map = vim.keymap.set
local builtin = require "telescope.builtin"
local live_grep_args = require("telescope").extensions.live_grep_args

map("n", "<leader>ff", builtin.find_files, { desc = "Telescope: Find files" })
map("n", "<leader>fa", live_grep_args.live_grep_args, { desc = "Telescope: Live grep (args)" })
map("n", "<leader>fw", builtin.grep_string, { desc = "Telescope: Search word under cursor" })
map("n", "<leader>fb", builtin.current_buffer_fuzzy_find, { desc = "Telescope: Search in current file" })
map("n", "<leader>fB", builtin.buffers, { desc = "Telescope: Buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope: Find help tags" })
map("n", "<leader>fr", builtin.resume, { desc = "Telescope: Resume" })

map("n", "<leader>fgf", builtin.git_files, { desc = "Git files" })
map("n", "<leader>fgc", builtin.git_commits, { desc = "Git commits" })
map("n", "<leader>fgs", builtin.git_status, { desc = "Git status" })
map("n", "<leader>fgb", builtin.git_branches, { desc = "Git branches" })

map("n", "<leader>fls", builtin.lsp_document_symbols, { desc = "LSP document symbols" })
map("n", "<leader>flw", builtin.lsp_workspace_symbols, { desc = "LSP workspace symbols" })
map("n", "<leader>fld", builtin.diagnostics, { desc = "LSP diagnostics" })
