local actions = require "telescope.actions"
local layout_actions = require "telescope.actions.layout"
local lga_actions = require "telescope-live-grep-args.actions"
local picker_width = function(_, columns)
  return math.min(math.floor(columns * 0.72), 110)
end
local picker_height = function(_, _, lines)
  return math.min(math.floor(lines * 0.72), 38)
end
local grep_layout = { vertical = { preview_height = 0.6 } }
local dropdown = require("telescope.themes").get_dropdown {
  previewer = false,
  layout_config = { width = picker_width, height = picker_height },
}

local layout_strategies = require "telescope.pickers.layout_strategies"
local vertical_layout = layout_strategies.vertical
layout_strategies.vertical = function(...)
  local layout = vertical_layout(...)
  if layout.prompt.line < layout.results.line then
    -- Share the prompt's bottom border with the results instead of leaving a blank row.
    layout.results.line = layout.results.line - 1
    layout.results.height = layout.results.height + 1
  end
  return layout
end

require("telescope").setup {
  pickers = {
    buffers = dropdown,
    oldfiles = dropdown,
    keymaps = dropdown,
    help_tags = dropdown,
    grep_string = { layout_config = grep_layout },
  },
  extensions = {
    live_grep_args = {
      layout_config = grep_layout,
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
        ["<C-p>"] = layout_actions.toggle_preview,
      },
      n = {
        ["<leader>q"] = actions.close,
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
        ["<C-d>"] = "preview_scrolling_down",
        ["<C-u>"] = "preview_scrolling_up",
        ["<C-p>"] = layout_actions.toggle_preview,
      },
    },
    prompt_prefix = "   ",
    selection_caret = "› ",
    entry_prefix = "  ",
    sorting_strategy = "ascending",
    results_title = false,
    borderchars = {
      prompt = { "─", "│", "─", "│", "╭", "╮", "┤", "├" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    path_display = {},
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        mirror = true,
        prompt_position = "top",
        width = picker_width,
        height = picker_height,
        preview_height = 0.62,
        preview_cutoff = 12,
      },
    },
  },
}
require("telescope").load_extension "fzf"
require("telescope").load_extension "live_grep_args"

do
  local telescope_utils = require "telescope.utils"
  local original_transform_devicons = telescope_utils.transform_devicons
  telescope_utils.transform_devicons = function(filename, display, disable_devicons)
    local icon_display, hl_group, icon = original_transform_devicons(filename, display, disable_devicons)
    if icon and icon_display then
      icon_display = icon .. "  " .. (display or "")
      hl_group = "TelescopeFileIcon"
    end
    return icon_display, hl_group, icon
  end
end

local map = vim.keymap.set
local builtin = require "telescope.builtin"
local live_grep_args = require("telescope").extensions.live_grep_args

map("n", "<leader>ff", builtin.find_files, { desc = "Telescope: Find files" })
map("n", "<leader>fa", live_grep_args.live_grep_args, { desc = "Telescope: Live grep with ripgrep args" })
map("n", "<leader>fw", builtin.grep_string, { desc = "Telescope: Search word under cursor" })
map("x", "<leader>fw", builtin.grep_string, { desc = "Telescope: Search selection" })
map("n", "<leader>fk", builtin.keymaps, { desc = "Telescope: Search keymaps" })
map("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope: Recent files" })
map("n", "<leader>fb", builtin.current_buffer_fuzzy_find, { desc = "Telescope: Fuzzy search current buffer" })
map("n", "<leader>fB", builtin.buffers, { desc = "Telescope: Open buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope: Search help tags" })
map("n", "<leader>fr", builtin.resume, { desc = "Telescope: Resume last picker" })

map("n", "<leader>fgf", builtin.git_files, { desc = "Telescope: Git files" })
map("n", "<leader>fgc", builtin.git_commits, { desc = "Telescope: Git commits" })
map("n", "<leader>fgs", builtin.git_status, { desc = "Telescope: Git status" })
map("n", "<leader>fgb", builtin.git_branches, { desc = "Telescope: Git branches" })

map("n", "<leader>fls", builtin.lsp_document_symbols, { desc = "Telescope: Document symbols" })
map("n", "<leader>flw", builtin.lsp_workspace_symbols, { desc = "Telescope: Workspace symbols" })
map("n", "<leader>fld", builtin.diagnostics, { desc = "Telescope: Workspace diagnostics" })
