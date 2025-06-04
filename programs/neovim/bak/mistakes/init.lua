if not vim.g.vscode then
  return {}
end -- don't do anything in non-vscode instances

return {
  { import = 'plugins.mistakes.vscode' },
}