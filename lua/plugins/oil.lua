local oil = require "oil"

oil.setup {
  default_file_explorer = false,
  columns = {
    "icon",
  },
  view_options = {
    show_hidden = true,
  },
  win_options = {
    signcolumn = "yes:2",
  },
  float = {
    open_by_default = true,
    padding = 0,
    max_width = 0.8,
    max_height = 0.8,
    border = "rounded",
    win_options = {
      winblend = 0,
      winhighlight = "NormalFloat:OilNormalFloat,FloatBorder:OilFloatBorder",
    },
  },
  keymaps = {
    ["<leader>e"] = { "actions.parent", mode = "n" },
  },
}
require("oil-git-status").setup {}

do
  local system = require("oil-git-status.system").system
  local oil_config = require "oil.config"
  local oil_view = require "oil.view"
  local ns = vim.api.nvim_create_namespace "oil-git-author"
  local git_info_enabled = false
  local mtime_column = { "mtime", highlight = "OilMtime" }

  local function unquote_git_file_name(s)
    local out = s:gsub('"(.*)"', "%1"):gsub('\\"', '"'):gsub("\\\\", "\\")
    return out
  end

  local function format_git_date(epoch)
    local year = vim.fn.strftime "%Y"
    if vim.fn.strftime("%Y", epoch) ~= year then
      return vim.fn.strftime("%b %d %Y", epoch)
    else
      return vim.fn.strftime("%b %d %H:%M", epoch)
    end
  end

  local function parse_git_info(stdout)
    local authors, dates = {}, {}
    local current_author, current_date
    for _, line in ipairs(vim.split(stdout or "", "\n")) do
      if line:sub(1, 1) == "\0" then
        local epoch, author = line:sub(2):match "^(%d+)\1(.*)$"
        current_author = author
        current_date = epoch and format_git_date(tonumber(epoch))
      elseif line ~= "" and current_author then
        local name = unquote_git_file_name(line):match "^([^/]+)"
        if name and not authors[name] then
          authors[name] = current_author
          dates[name] = current_date
        end
      end
    end
    return authors, dates
  end

  local function mtime_content_starts(buffer)
    local starts = {}
    local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
    for i, line in ipairs(lines) do
      local s = line:match "^%S+%s+%S+%s+()"
      if s then
        starts[i - 1] = s - 1
      end
    end
    return starts
  end

  local function name_start_col(buffer)
    local starts = {}
    local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
    for i, line in ipairs(lines) do
      local entry = oil.get_entry_on_line(buffer, i)
      if entry and entry.name ~= ".." then
        local suffix = entry.type == "directory" and (entry.name .. "/") or entry.name
        if line:sub(-#suffix) == suffix then
          starts[i - 1] = #line - #suffix
        end
      end
    end
    return starts
  end

  local function add_git_info_extmarks(buffer, authors, dates)
    vim.api.nvim_buf_clear_namespace(buffer, ns, 0, -1)
    if not authors then
      return
    end
    local mtime_starts = mtime_content_starts(buffer)
    local name_starts = name_start_col(buffer)

    local line_count = vim.api.nvim_buf_line_count(buffer)
    local width = 0
    for n = 1, line_count do
      local entry = oil.get_entry_on_line(buffer, n)
      local author = entry and entry.name ~= ".." and authors[entry.name]
      if author and mtime_starts[n - 1] then
        width = math.max(width, #author)
      end
    end
    if width == 0 then
      return
    end

    for n = 1, line_count do
      local entry = oil.get_entry_on_line(buffer, n)
      local mtime_start = mtime_starts[n - 1]
      if mtime_start and entry and entry.name ~= ".." then
        local author = authors[entry.name] or ""
        local text = author .. string.rep(" ", width - #author)
        vim.api.nvim_buf_set_extmark(buffer, ns, n - 1, mtime_start - 1, {
          virt_text = { { " " .. text, "OilGitAuthor" } },
          virt_text_pos = "inline",
        })

        local date = dates[entry.name]
        local name_start = name_starts[n - 1]
        if date and name_start then
          local mtime_width = name_start - 1 - mtime_start
          if mtime_width > 0 then
            local overlay = date
            if #overlay > mtime_width then
              overlay = overlay:sub(1, mtime_width)
            else
              overlay = string.rep(" ", mtime_width - #overlay) .. overlay
            end
            vim.api.nvim_buf_set_extmark(buffer, ns, n - 1, mtime_start, {
              virt_text = { { overlay, "OilMtime" } },
              virt_text_pos = "overlay",
            })
          end
        end
      end
    end
  end

  local function load_git_info(buffer, callback)
    local oil_url = vim.api.nvim_buf_get_name(buffer)
    local path = vim.uri_to_fname((oil_url:gsub("^oil", "file")))
    system({
      "git",
      "-c",
      "core.quotepath=false",
      "log",
      "--relative",
      "--format=%x00%at%x01%an",
      "--name-only",
      "--",
      ".",
    }, { text = true, cwd = path }, function(result)
      vim.schedule(function()
        if result.code ~= 0 then
          return callback()
        end
        callback(parse_git_info(result.stdout))
      end)
    end)
  end

  local refresh_by_buf = {}
  vim.api.nvim_create_autocmd("User", {
    pattern = "OilEnter",
    callback = function(args)
      local buf = args.data and args.data.buf
      local refresh = buf and refresh_by_buf[buf]
      if refresh then
        refresh()
      end
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "oil",
    callback = function()
      local buffer = vim.api.nvim_get_current_buf()
      if vim.b[buffer].oil_git_author_started then
        return
      end
      vim.b[buffer].oil_git_author_started = true

      local current_authors, current_dates
      local function refresh()
        if not git_info_enabled then
          return
        end
        load_git_info(buffer, function(authors, dates)
          current_authors, current_dates = authors, dates
          add_git_info_extmarks(buffer, current_authors, current_dates)
        end)
      end
      refresh_by_buf[buffer] = refresh

      vim.api.nvim_create_autocmd("BufWritePost", {
        buffer = buffer,
        callback = refresh,
      })
      vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
        buffer = buffer,
        callback = function()
          if git_info_enabled and current_authors then
            add_git_info_extmarks(buffer, current_authors, current_dates)
          end
        end,
      })
      vim.api.nvim_create_autocmd("BufWipeout", {
        buffer = buffer,
        once = true,
        callback = function()
          refresh_by_buf[buffer] = nil
        end,
      })
    end,
  })

  vim.keymap.set("n", "<leader>tg", function()
    git_info_enabled = not git_info_enabled
    oil_config.columns = git_info_enabled and { "icon", mtime_column } or { "icon" }
    oil_view.rerender_all_oil_buffers({ refetch = true }, function()
      for buf, refresh in pairs(refresh_by_buf) do
        if git_info_enabled then
          refresh()
        else
          vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
        end
      end
    end)
    vim.notify("Oil git author/timestamp: " .. (git_info_enabled and "on" or "off"))
  end, { desc = "Toggle git author/timestamp info in Oil" })
end

local map = vim.keymap.set

map("n", "<leader>e", function()
  if not oil.get_current_dir() then
    oil.open_float()
  end
end, { desc = "Toggle Oil file explorer" })
