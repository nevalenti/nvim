local lint = require "lint"

lint.linters_by_ft = {
  python = { "ruff" },
  php = { "phpstan" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
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
