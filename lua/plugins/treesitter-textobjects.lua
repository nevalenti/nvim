require("nvim-treesitter-textobjects").setup {
  select = {
    lookahead = true,
    selection_modes = {
      ["@parameter.outer"] = "v",
      ["@function.outer"] = "V",
      ["@class.outer"] = "V",
    },
  },
  move = {
    set_jumps = true,
  },
}

local move = require "nvim-treesitter-textobjects.move"
local select = require "nvim-treesitter-textobjects.select"
local swap = require "nvim-treesitter-textobjects.swap"

local map = vim.keymap.set

local function select_textobject(query)
  return function()
    select.select_textobject(query, "textobjects")
  end
end

map({ "x", "o" }, "af", select_textobject "@function.outer", { desc = "Around function" })
map({ "x", "o" }, "if", select_textobject "@function.inner", { desc = "Inside function" })
map({ "x", "o" }, "ac", select_textobject "@class.outer", { desc = "Around class" })
map({ "x", "o" }, "ic", select_textobject "@class.inner", { desc = "Inside class" })
map({ "x", "o" }, "aa", select_textobject "@parameter.outer", { desc = "Around argument" })
map({ "x", "o" }, "ia", select_textobject "@parameter.inner", { desc = "Inside argument" })
map({ "x", "o" }, "ai", select_textobject "@conditional.outer", { desc = "Around conditional" })
map({ "x", "o" }, "ii", select_textobject "@conditional.inner", { desc = "Inside conditional" })
map({ "x", "o" }, "al", select_textobject "@loop.outer", { desc = "Around loop" })
map({ "x", "o" }, "il", select_textobject "@loop.inner", { desc = "Inside loop" })

local function goto_textobject(fn, query)
  return function()
    fn(query, "textobjects")
  end
end

map({ "n", "x", "o" }, "]m", goto_textobject(move.goto_next_start, "@function.outer"), { desc = "Next function start" })
map({ "n", "x", "o" }, "]M", goto_textobject(move.goto_next_end, "@function.outer"), { desc = "Next function end" })
map(
  { "n", "x", "o" },
  "[m",
  goto_textobject(move.goto_previous_start, "@function.outer"),
  { desc = "Previous function start" }
)
map(
  { "n", "x", "o" },
  "[M",
  goto_textobject(move.goto_previous_end, "@function.outer"),
  { desc = "Previous function end" }
)

map("n", "<leader>na", function()
  swap.swap_next "@parameter.inner"
end, { desc = "Swap argument with next" })
map("n", "<leader>pa", function()
  swap.swap_previous "@parameter.inner"
end, { desc = "Swap argument with previous" })
