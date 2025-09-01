local map = vim.keymap.set
local builtin = require('telescope.builtin')

map('n', '<leader>ff', builtin.find_files, { desc = "Telescope: Find files" })
map('n', '<leader>fg', builtin.live_grep, { desc = "Telescope: Live grep" })
map("n", "<leader>fw", builtin.grep_string, { desc = "Telescope: Search word under cursor" })
map("n", "<leader>fb", builtin.current_buffer_fuzzy_find, { desc = "Telescope: Search in current file" })
map('n', '<leader>fB', builtin.buffers, { desc = "Telescope: Buffers" })
map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope: Find help tags' })
map('n', '<leader>fr', builtin.resume, { desc = "Telescope: Resume" })

map('n', '<leader>gf', builtin.git_files, { desc = 'Find Git files' })
map('n', '<leader>gc', builtin.git_commits, { desc = 'Git commits' })
map('n', '<leader>gs', builtin.git_status, { desc = 'Git status' })
map('n', '<leader>gb', builtin.git_branches, { desc = 'Git branches' })

map('n', '<leader>ls', builtin.lsp_document_symbols, { desc = 'LSP document symbols' })
map('n', '<leader>lw', builtin.lsp_workspace_symbols, { desc = 'LSP workspace symbols' })
map('n', '<leader>ld', builtin.diagnostics, { desc = 'LSP diagnostics' })

map('n', '<leader>fq', builtin.quickfix, { desc = 'Quickfix list' })
map('n', '<leader>fl', builtin.loclist, { desc = 'Location list' })
