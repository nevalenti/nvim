require("codecompanion").setup({
  strategies = {
    chat = { adapter = "anthropic" },
    inline = {
      adapter = "anthropic",
      system_prompt = [[
You are an expert software engineer.

Modify ONLY the selected code.
Preserve formatting, style, and intent.
Prefer minimal diffs.

If the change would affect code outside the selection,
DO NOT make the change.

If you are unsure, return the original code unchanged.
Do not explain unless asked.
]],
    },
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
    inline = {
      diff = false,
      layout = "floating",
    },
    chat = {
      window = { layout = "vertical" },
      render_headers = false,
    },
  },
})

local map = vim.keymap.set

map({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<CR>", {
  noremap = true,
  silent = true,
  desc = "CodeCompanion: Toggle Chat",
})

map({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<CR>", {
  noremap = true,
  silent = true,
  desc = "CodeCompanion: Actions Menu",
})

map("v", "<leader>ci", ":CodeCompanion<CR>", {
  noremap = true,
  silent = true,
  desc = "CodeCompanion: Inline Prompt",
})

map("v", "<leader>cs", "<cmd>CodeCompanionChat Add<CR>", {
  noremap = true,
  silent = true,
  desc = "CodeCompanion: Add Selection to Chat",
})
