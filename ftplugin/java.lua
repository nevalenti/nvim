require("lazy-load").load "dap"

local jdtls = require "jdtls"

local root_dir = require("jdtls.setup").find_root { "gradlew", "mvnw", ".git" }
if not root_dir then
  return
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath "data" .. "/site/java/workspace/" .. project_name

local mason_packages = vim.fn.stdpath "data" .. "/mason/packages"
local jdtls_path = mason_packages .. "/jdtls"

local system = "linux"
if vim.fn.has "mac" == 1 then
  system = "mac"
elseif vim.fn.has "win32" == 1 then
  system = "win"
end

local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local config_dir = jdtls_path .. "/config_" .. system

local bundles = {}
local java_debug_path = mason_packages .. "/java-debug-adapter"
vim.list_extend(
  bundles,
  vim.split(vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true), "\n")
)

local java_test_path = mason_packages .. "/java-test"
vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", true), "\n"))

require("jdtls").start_or_attach {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    launcher_jar,
    "-configuration",
    config_dir,
    "-data",
    workspace_dir,
  },

  root_dir = root_dir,
  capabilities = require("blink.cmp").get_lsp_capabilities(),

  settings = {
    java = {
      eclipse = { downloadSources = true },
      maven = { downloadSources = true },
      configuration = { updateBuildConfiguration = "interactive" },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      signatureHelp = { enabled = true },
    },
  },

  init_options = {
    bundles = bundles,
  },

  on_attach = function(_, bufnr)
    jdtls.setup_dap { hotcodereplace = "auto" }
    require("jdtls.dap").setup_dap_main_class_configs()

    local map = vim.keymap.set
    local opts = { buffer = bufnr }
    map("n", "<leader>jo", jdtls.organize_imports, opts)
    map("n", "<leader>jv", jdtls.extract_variable, opts)
    map("v", "<leader>jv", function()
      jdtls.extract_variable(true)
    end, opts)
    map("n", "<leader>jc", jdtls.extract_constant, opts)
    map("v", "<leader>jc", function()
      jdtls.extract_constant(true)
    end, opts)
    map("v", "<leader>jm", function()
      jdtls.extract_method(true)
    end, opts)
    map("n", "<leader>jt", jdtls.test_class, opts)
    map("n", "<leader>jn", jdtls.test_nearest_method, opts)
  end,
}
