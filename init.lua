vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(event)
    local data = event.data
    if data.spec.name == "nvim-dbee" and (data.kind == "install" or data.kind == "update") then
      vim.cmd.packadd "nui.nvim"
      if not data.active then
        vim.cmd.packadd "nvim-dbee"
      end
      vim.schedule(function()
        local ok, dbee = pcall(require, "dbee")
        if ok then
          pcall(dbee.install)
        end
      end)
    end
  end,
})

vim.pack.add {
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/echasnovski/mini.icons" },
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  { src = "https://github.com/echasnovski/mini.cursorword" },
  { src = "https://github.com/echasnovski/mini.starter" },

  { src = "https://github.com/Mofiqul/dracula.nvim" },
  { src = "https://github.com/loctvl842/monokai-pro.nvim" },
  { src = "https://github.com/rebelot/kanagawa.nvim" },
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  { src = "https://github.com/sainnhe/gruvbox-material" },
  { src = "https://github.com/blazkowolf/gruber-darker.nvim" },
  { src = "https://github.com/bluz71/vim-nightfly-colors", name = "nightfly" },
  { src = "https://github.com/Mofiqul/vscode.nvim" },
  { src = "https://github.com/scottmckendry/cyberdream.nvim" },
  { src = "https://github.com/nyoom-engineering/oxocarbon.nvim" },
  { src = "https://github.com/olivercederborg/poimandres.nvim" },
  { src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
  { src = "https://github.com/folke/tokyonight.nvim" },
  { src = "https://github.com/EdenEast/nightfox.nvim" },
  { src = "https://github.com/sainnhe/sonokai" },

  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/rcarriga/nvim-notify" },
  { src = "https://github.com/folke/noice.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/stevearc/dressing.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/lewis6991/satellite.nvim" },
  { src = "https://github.com/folke/persistence.nvim" },
  { src = "https://github.com/akinsho/toggleterm.nvim" },
  { src = "https://github.com/kndndrj/nvim-dbee" },

  { src = "https://github.com/mbbill/undotree" },

  { src = "https://github.com/nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },

  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/mfussenegger/nvim-jdtls" },
  { src = "https://github.com/seblyng/roslyn.nvim" },
  { src = "https://github.com/SmiteshP/nvim-navic" },
  { src = "https://github.com/kevinhwang91/promise-async" },
  { src = "https://github.com/kevinhwang91/nvim-ufo" },
  { src = "https://github.com/saghen/blink.cmp", build = "cargo build --release" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/mfussenegger/nvim-lint" },

  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },

  { src = "https://github.com/kylechui/nvim-surround" },
  { src = "https://github.com/m4xshen/autoclose.nvim" },
  { src = "https://github.com/numToStr/Comment.nvim" },

  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", ft = { "markdown" } },
}

require "options"
require "diagnostics"
require "mappings"
require "autocommands"

require "theme"
require "plugins.mini-icons"
require "plugins.indent-blankline"
require "plugins.mini-cursorword"
require "plugins.mini-starter"
require "plugins.noice"

vim.schedule(function()
  require "plugins.notify"
end)
vim.schedule(function()
  require "plugins.statusline"
end)
require "plugins.which-key"
vim.schedule(function()
  require "plugins.ufo"
end)
vim.schedule(function()
  require "plugins.satellite"
end)
require "plugins.persistence"

local lazy = require "lazy-load"

lazy.on_keys("zen-mode", { { "n", "<leader>zz", "Toggle distraction-free mode" } })
require "plugins.toggleterm"
require "plugins.backend"
require "plugins.dbee"

lazy.on_keys("oil", {
  { "n", "<leader>e", "Browse files" },
  { "n", "<leader>tg", "Open Git file browser" },
})
lazy.on_keys("telescope", {
  { "n", "<leader>ff", "Find files" },
  { "n", "<leader>fa", "Search project" },
  { "n", "<leader>fw", "Search word under cursor" },
  { "n", "<leader>fb", "Search current buffer" },
  { "n", "<leader>fB", "List open buffers" },
  { "n", "<leader>fh", "Search help tags" },
  { "n", "<leader>fr", "Resume last search" },
  { "n", "<leader>fgf", "List Git files" },
  { "n", "<leader>fgc", "Search Git commits" },
  { "n", "<leader>fgs", "Show Git status" },
  { "n", "<leader>fgb", "List Git branches" },
  { "n", "<leader>fls", "List document symbols" },
  { "n", "<leader>flw", "List workspace symbols" },
  { "n", "<leader>fld", "List diagnostics" },
})
require "plugins.undotree"
lazy.on_keys("harpoon", {
  { "n", "<leader>ha", "Add file to Harpoon" },
  { "n", "<leader>hh", "Open Harpoon menu" },
  { "n", "<leader>1", "Jump to Harpoon file 1" },
  { "n", "<leader>2", "Jump to Harpoon file 2" },
  { "n", "<leader>3", "Jump to Harpoon file 3" },
  { "n", "<leader>4", "Jump to Harpoon file 4" },
})

require "plugins.treesitter"
require "plugins.treesitter-textobjects"
require "plugins.navic"
require "plugins.lsp"
require "plugins.roslyn"
require "plugins.conform"
require "plugins.lint"

lazy.on_keys("trouble", { { "n", "<leader>tt", "Toggle diagnostics list" } })

require "plugins.gitsigns"
lazy.on_keys("diffview", {
  { "n", "<leader>gv", "Open Git diff view" },
  { "n", "<leader>gh", "Show file Git history" },
  { "v", "<leader>gh", "Show selected-lines Git history" },
})

lazy.on_keys("dap", {
  { "n", "<F5>", "Start or continue debugging" },
  { "n", "<F10>", "Debug: Step over" },
  { "n", "<F11>", "Debug: Step into" },
  { "n", "<F12>", "Debug: Step out" },
  { "n", "<Leader>b", "Toggle breakpoint" },
  { "n", "<Leader>B", "Set conditional breakpoint" },
  { "n", "<Leader>du", "Toggle debugger UI" },
  { "n", "<Leader>dt", "Terminate debug session" },
  { "n", "<Leader>de", "Evaluate expression" },
  { "v", "<Leader>de", "Evaluate selected expression" },
  { "n", "<Leader>dm", "Debug Python test method" },
  { "n", "<Leader>dc", "Debug Python test class" },
})
lazy.on_keys("neotest", {
  { "n", "<leader>t", "Run nearest test" },
  { "n", "<leader>tr", "Run nearest test" },
  { "n", "<leader>tf", "Run tests in current file" },
  { "n", "<leader>td", "Debug nearest test" },
  { "n", "<leader>ts", "Toggle test summary" },
  { "n", "<leader>to", "Toggle test output" },
  { "n", "<leader>tS", "Stop running tests" },
  { "n", "]n", "Jump to next failed test" },
  { "n", "[n", "Jump to previous failed test" },
})

require "plugins.autoclose"
require "plugins.surround"
require "plugins.comment"
require "plugins.autotag"

lazy.on_keys("avante", {
  { "n", "<leader>aa", "Open AI assistant" },
  { "v", "<leader>aa", "Open AI assistant" },
  { "n", "<leader>az", "Toggle AI assistant" },
  { "v", "<leader>az", "Toggle AI assistant" },
  { "n", "<leader>an", "New AI assistant prompt" },
  { "v", "<leader>an", "New AI assistant prompt" },
  { "v", "<leader>ae", "Edit AI assistant prompt" },
  { "n", "<leader>aS", "Select AI assistant sidebar" },
  { "n", "<leader>ar", "Refresh AI assistant" },
  { "n", "<leader>af", "Focus AI assistant" },
  { "n", "<leader>at", "Toggle AI assistant chat" },
  { "n", "<leader>ad", "Toggle AI assistant debug" },
  { "n", "<leader>aC", "Clear AI assistant" },
  { "n", "<leader>as", "Stop AI assistant request" },
  { "n", "<leader>aR", "Reset AI assistant" },
  { "n", "<leader>a?", "Show AI assistant help" },
  { "n", "<leader>ah", "Show AI assistant history" },
  { "n", "<leader>aB", "Toggle AI assistant sidebar" },
})
lazy.on_cmd("avante", "Avante*")

require "plugins.render-markdown"
