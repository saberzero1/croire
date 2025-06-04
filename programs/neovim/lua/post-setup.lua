if vim.g.vscode then
  require 'plugins.mistakes.azure-data-studio'
end

--require 'config.options'
--require 'config.keymaps'
--require 'config.autocmds'

--vim.o.statuscolumn = "%!v:lua.require('scripts.status-column').status_bar()"
require 'scripts.highlight'

--require 'scripts.keychecker'

local alpha = function()
  return string.format("%x", math.floor(255 * (vim.g.neovide_transparency_point or 0.8)))
end

if vim.g.neovide then
  -- Set transparency and background color (title bar color)
  vim.g.neovide_background_color_base = '#2a2839'
  vim.g.neovide_background_color = vim.g.neovide_background_color_base .. alpha()
  vim.cmd[[colorscheme tokyonight]]
elseif vim.g.vscode then
  -- vim.cmd[[colorscheme tokyonight]] -- setting
end
