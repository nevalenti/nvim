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
  { src = "https://github.com/oxfist/night-owl.nvim" },
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
  { src = "https://github.com/stevearc/overseer.nvim" },
  { src = "https://github.com/dont-be-evil-company/kulala.nvim", version = "v5.3.4" },

  { src = "https://github.com/mbbill/undotree" },

  { src = "https://github.com/nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/lewis6991/async.nvim" },
  { src = "https://github.com/ThePrimeagen/refactoring.nvim" },

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
require "plugins.overseer"
require "plugins.backend"
lazy.on_keys("dbee", {
  { "n", "<leader>db", "Database: Toggle dbee workspace" },
  { "n", "<leader>do", "Database: Open dbee workspace" },
})
lazy.on_cmd("dbee", "Dbee*")

lazy.on_keys("oil", {
  { "n", "<leader>e", "Toggle Oil file explorer" },
  { "n", "<leader>tg", "Toggle git author/timestamp info in Oil" },
})
lazy.on_keys("telescope", {
  { "n", "<leader>ff", "Telescope: Find files" },
  { "n", "<leader>fa", "Telescope: Live grep with ripgrep args" },
  { "n", "<leader>fw", "Telescope: Search word under cursor" },
  { "x", "<leader>fw", "Telescope: Search selection" },
  { "n", "<leader>fk", "Telescope: Search keymaps" },
  { "n", "<leader>fo", "Telescope: Recent files" },
  { "n", "<leader>fb", "Telescope: Fuzzy search current buffer" },
  { "n", "<leader>fB", "Telescope: Open buffers" },
  { "n", "<leader>fh", "Telescope: Search help tags" },
  { "n", "<leader>fr", "Telescope: Resume last picker" },
  { "n", "<leader>fgf", "Telescope: Git files" },
  { "n", "<leader>fgc", "Telescope: Git commits" },
  { "n", "<leader>fgs", "Telescope: Git status" },
  { "n", "<leader>fgb", "Telescope: Git branches" },
  { "n", "<leader>fls", "Telescope: Document symbols" },
  { "n", "<leader>flw", "Telescope: Workspace symbols" },
  { "n", "<leader>fld", "Telescope: Workspace diagnostics" },
})
require "plugins.undotree"
lazy.on_keys("harpoon", {
  { "n", "<leader>ha", "Harpoon: Add current file" },
  { "n", "<leader>hh", "Harpoon: Toggle quick menu" },
  { "n", "[h", "Harpoon: Previous file" },
  { "n", "]h", "Harpoon: Next file" },
  { "n", "<leader>1", "Harpoon: Jump to file 1" },
  { "n", "<leader>2", "Harpoon: Jump to file 2" },
  { "n", "<leader>3", "Harpoon: Jump to file 3" },
  { "n", "<leader>4", "Harpoon: Jump to file 4" },
})

require "plugins.treesitter"
require "plugins.treesitter-textobjects"
require "plugins.refactoring"
require "plugins.navic"
require "plugins.lsp"
require "plugins.roslyn"
require "plugins.conform"
require "plugins.lint"

lazy.on_keys("trouble", {
  { "n", "<leader>tt", "Trouble: Toggle diagnostics" },
  { "n", "<leader>tQ", "Trouble: Toggle quickfix list" },
  { "n", "<leader>ls", "Trouble: Toggle symbols outline" },
  { "n", "<leader>lci", "Trouble: Incoming calls" },
  { "n", "<leader>lco", "Trouble: Outgoing calls" },
})

require "plugins.gitsigns"
lazy.on_keys("diffview", {
  { "n", "<leader>gv", "Diffview: Open working tree changes" },
  { "n", "<leader>gh", "Diffview: Current file history" },
  { "v", "<leader>gh", "Diffview: History of selected lines" },
})

lazy.on_keys("dap", {
  { "n", "<F5>", "Debug: Start or continue" },
  { "n", "<F10>", "Debug: Step over" },
  { "n", "<F11>", "Debug: Step into" },
  { "n", "<F12>", "Debug: Step out" },
  { "n", "<Leader>b", "Debug: Toggle breakpoint" },
  { "n", "<Leader>B", "Debug: Set conditional breakpoint" },
  { "n", "<Leader>du", "Debug: Toggle debugger UI" },
  { "n", "<Leader>dt", "Debug: Terminate session" },
  { "n", "<Leader>de", "Debug: Evaluate expression under cursor" },
  { "v", "<Leader>de", "Debug: Evaluate selection" },
  { "n", "<Leader>dC", "Debug: Run to cursor" },
  { "n", "<Leader>dr", "Debug: Restart session" },
  { "n", "<Leader>dl", "Debug: Rerun last configuration" },
  { "n", "<Leader>dm", "Debug: Nearest Python test method" },
  { "n", "<Leader>dc", "Debug: Nearest Python test class" },
})
lazy.on_keys("neotest", {
  { "n", "<leader>tr", "Neotest: Run nearest test" },
  { "n", "<leader>tf", "Neotest: Run tests in current file" },
  { "n", "<leader>td", "Neotest: Debug nearest test" },
  { "n", "<leader>ts", "Neotest: Toggle summary panel" },
  { "n", "<leader>to", "Neotest: Toggle output panel" },
  { "n", "<leader>tS", "Neotest: Stop running tests" },
  { "n", "]n", "Neotest: Next failed test" },
  { "n", "[n", "Neotest: Previous failed test" },
})

require "plugins.autoclose"
require "plugins.surround"
require "plugins.comment"
require "plugins.autotag"

lazy.on_keys("avante", {
  { "n", "<leader>aa", "Avante: Ask" },
  { "v", "<leader>aa", "Avante: Ask" },
  { "n", "<leader>az", "Avante: Toggle Zen Mode" },
  { "v", "<leader>az", "Avante: Toggle Zen Mode" },
  { "n", "<leader>an", "Avante: Create new ask" },
  { "v", "<leader>an", "Avante: Create new ask" },
  { "v", "<leader>ae", "Avante: Edit" },
  { "n", "<leader>aS", "Avante: Stop" },
  { "n", "<leader>ar", "Avante: Refresh" },
  { "n", "<leader>af", "Avante: Focus" },
  { "n", "<leader>at", "Avante: Toggle" },
  { "n", "<leader>ad", "Avante: Toggle debug" },
  { "n", "<leader>aC", "Avante: Toggle selection" },
  { "n", "<leader>as", "Avante: Toggle suggestion" },
  { "n", "<leader>aR", "Avante: Display repo map" },
  { "n", "<leader>a?", "Avante: Select model" },
  { "n", "<leader>ah", "Avante: Select history" },
  { "n", "<leader>aB", "Avante: Add all open buffers" },
})
lazy.on_cmd("avante", "Avante*")

require "plugins.render-markdown"
