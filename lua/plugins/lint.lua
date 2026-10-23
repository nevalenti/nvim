local lint = require "lint"

vim.list_extend(lint.linters.mypy.args, {
  "--python-executable",
  function()
    return require("python-env").resolve()
  end,
})

lint.linters_by_ft = {
  python = { "ruff", "mypy" },
  php = { "phpstan" },
}

vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function(args)
    if not vim.api.nvim_buf_is_valid(args.buf) then
      return
    end

    local filetype = vim.bo[args.buf].filetype
    if not lint.linters_by_ft[filetype] then
      return
    end

    vim.api.nvim_buf_call(args.buf, lint.try_lint)
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function(args)
    if vim.api.nvim_buf_is_valid(args.buf) and vim.bo[args.buf].filetype == "python" then
      vim.api.nvim_buf_call(args.buf, function()
        lint.try_lint "ruff"
      end)
    end
  end,
})
