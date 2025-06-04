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
]]--
return {}
