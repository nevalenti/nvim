require("codecompanion").setup({
  strategies = {
    chat = { adapter = "anthropic" },
    inline = { adapter = "anthropic" },
  },
  adapters = {
    anthropic = function()
      return require("codecompanion.adapters").extend("anthropic", {
        schema = {
          model = {
            default = "claude-3-5-sonnet-20241022",
          },
        },
      })
    end,
  },
  display = {
    chat = {
      window = {
        layout = "vertical",
      },
    },
  },
})

local map = vim.keymap.set
local tbl_extend = vim.tbl_extend
local opts = { noremap = true, silent = true }

map({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<CR>",
  tbl_extend("force", opts, { desc = "CodeCompanion: Toggle Chat" }))

map({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<CR>",
  tbl_extend("force", opts, { desc = "CodeCompanion: Actions Menu" }))

map({ "n", "v" }, "<leader>ci", "<cmd>CodeCompanion<CR>",
  tbl_extend("force", opts, { desc = "CodeCompanion: Inline Prompt" }))

map("v", "ga", "<cmd>CodeCompanionChat Add<CR>",
  tbl_extend("force", opts, { desc = "CodeCompanion: Add Selection to Chat" }))

map("i", "<C-j>", function()
  return vim.fn["codecompanion#InlineSuggestionAccept"]()
end, tbl_extend("force", opts, { expr = true, desc = "CodeCompanion: Accept Inline Suggestion" }))
