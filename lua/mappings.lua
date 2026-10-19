local map = vim.keymap.set

map("i", "jj", "<Esc>", { desc = "Exit insert mode" })

map("n", "<Space>", "<Nop>", { silent = true, desc = "Disable Space (reserved for leader)" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader><CR>", "<cmd>cd %:h<CR>", { desc = "Set CWD to current file" })

map("n", "<leader>o", "<cmd>update<CR><cmd>source<CR>", { desc = "Save and source current file" })
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit window" })
map("n", "<leader>Q", "<cmd>quit!<CR>", { desc = "Force quit window" })

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move to right window" })

map("n", "n", "nzzzv", { desc = "Next search result and center" })
map("n", "N", "Nzzzv", { desc = "Previous search result and center" })
map("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line up" })

local function quarter_page_scroll()
  return math.max(1, math.floor(vim.fn.winheight(0) / 4))
end

map("n", "<C-d>", function()
  return quarter_page_scroll() .. "<C-d>zz"
end, { expr = true, desc = "Scroll down one quarter page and center" })
map("n", "<C-u>", function()
  return quarter_page_scroll() .. "<C-u>zz"
end, { expr = true, desc = "Scroll up one quarter page and center" })

map("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
map("n", "[q", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })

map("n", "]l", "<cmd>lnext<CR>zz", { desc = "Next location list item" })
map("n", "[l", "<cmd>lprev<CR>zz", { desc = "Previous location list item" })

map(
  "n",
  "<leader>sr",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Search and replace word under cursor" }
)
map("x", "<leader>sr", [["zy:%s/\V<C-r>z//gI<Left><Left><Left>]], { desc = "Search and replace selection" })

map("x", "<", "<gv", { desc = "Indent left and keep selection" })
map("x", ">", ">gv", { desc = "Indent right and keep selection" })
map("x", "<leader>p", [["_dP]], { desc = "Paste over selection without yanking it" })
map({ "n", "x" }, "<leader>D", [["_d]], { desc = "Delete without yanking" })

for _, ch in ipairs { ",", ".", ";" } do
  map("i", ch, ch .. "<C-g>u", { desc = "Insert with undo breakpoint" })
end

map("n", "<leader>k", "<cmd>bp|bd #<CR>", { desc = "Delete buffer and keep window" })
map("n", "<leader>K", "<cmd>%bd|e#|bd#<CR>", { desc = "Delete other buffers" })

map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

map("n", "<leader>cq", function()
  local open = vim.iter(vim.fn.getwininfo()):any(function(win)
    return win.quickfix == 1
  end)
  vim.cmd(open and "cclose" or "copen")
end, { desc = "Toggle quickfix list" })

map("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment on line" })
map("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment on selection" })

map("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file executable" })

map("n", "<leader>tl", function()
  local cfg = vim.diagnostic.config()
  if cfg.virtual_lines then
    vim.diagnostic.config { virtual_lines = false }
  else
    vim.diagnostic.config { virtual_lines = { current_line = true } }
  end
end, { desc = "Toggle diagnostic virtual lines" })

map("n", "<leader>tq", function()
  vim.diagnostic.setqflist { open = true }
end, { desc = "Send all diagnostics to quickfix list" })

map("n", "<leader>yp", function()
  local path = vim.fn.expand "%:p"
  vim.fn.setreg("+", path)
  vim.notify(path)
end, { desc = "Yank full file path" })

map("n", "<leader>yP", function()
  local path = vim.fn.expand "%"
  vim.fn.setreg("+", path)
  vim.notify(path)
end, { desc = "Yank relative file path" })
