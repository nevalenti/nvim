vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local ufo = require "ufo"

local function fold_text(virt_text, lnum, end_lnum, width, truncate)
  local new_virt_text = {}
  local suffix = ("  %d lines"):format(end_lnum - lnum)
  local target_width = width - vim.fn.strdisplaywidth(suffix)
  local cur_width = 0
  for _, chunk in ipairs(virt_text) do
    local chunk_text = chunk[1]
    local chunk_width = vim.fn.strdisplaywidth(chunk_text)
    if target_width > cur_width + chunk_width then
      table.insert(new_virt_text, chunk)
    else
      chunk_text = truncate(chunk_text, target_width - cur_width)
      local hl_group = chunk[2]
      table.insert(new_virt_text, { chunk_text, hl_group })
      chunk_width = vim.fn.strdisplaywidth(chunk_text)
      if cur_width + chunk_width < target_width then
        suffix = suffix .. string.rep(" ", target_width - cur_width - chunk_width)
      end
      break
    end
    cur_width = cur_width + chunk_width
  end
  table.insert(new_virt_text, { suffix, "Comment" })
  return new_virt_text
end

ufo.setup {
  fold_virt_text_handler = fold_text,
  provider_selector = function()
    return { "treesitter", "indent" }
  end,
}

local map = vim.keymap.set
map("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
map("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
map("n", "zK", ufo.peekFoldedLinesUnderCursor, { desc = "Peek folded lines under cursor" })
