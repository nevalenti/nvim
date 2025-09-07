local function input_with_completion(opts, on_confirm)
  local default = opts.default or ''
  local prompt = opts.prompt or 'Input:'
  local completion = opts.completion or 'file'

  vim.fn.inputsave()
  local result = vim.fn.input(prompt, default, completion)
  vim.fn.inputrestore()

  if result ~= '' then
    on_confirm(result)
  else
    on_confirm(nil)
  end
end

vim.ui.input = input_with_completion
