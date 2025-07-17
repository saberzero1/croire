--[[if vim.g.vscode then
  return {
    { import = 'plugins.mistakes'},
  }
else
  return {
    { import = 'plugins.core' },
    { import = 'plugins.coding' },
    { import = 'plugins.navigation' },
    { import = 'plugins.editor' },
    { import = 'plugins.util' },
    { import = 'plugins.skill-issues' },
    { import = 'plugins.integration' },
  }
end
]]
--
return {
  { import = 'plugins.colorizer' },
  { import = 'plugins.discord' },
  { import = 'plugins.editor' },
  { import = 'plugins.explorer' },
  { import = 'plugins.gutter' },
  { import = 'plugins.hydra' },
  { import = 'plugins.lsp' },
  { import = 'plugins.multicursor' },
  { import = 'plugins.precognition' },
  { import = 'plugins.snacks' },
  { import = 'plugins.theme' },
}
