-- Gruber Modern; the palette, groups and options live in lua/gruber-modern/.
-- Reloading the submodules lets `:colorscheme gruber-modern` pick up edits;
-- the top-level module keeps the options from setup().
for module in pairs(package.loaded) do
  if module:match "^gruber%-modern%." then
    package.loaded[module] = nil
  end
end
require("gruber-modern").load()
