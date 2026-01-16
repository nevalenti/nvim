require("avante").setup({
  provider = "claude",
  instructions_file = "avante.md",
  providers = {
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-sonnet-4-5-20250929",
      timeout = 30000,
      extra_request_body = {
        temperature = 0.75,
        max_tokens = 20480,
      },
      api_key_name = "ANTHROPIC_API_KEY"
    },
  },
})
