if not vim.g.vscode then
  return {}
end -- don't do anything in non-vscode instances

local vscode = require 'vscode'

vim.keymap.set('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.localleader = ' '

vim.keymap.set('n', '<leader>q', function()
  vscode.action 'workbench.action.closeWindow'
end)
vim.keymap.set('n', '<leader>w', function()
  vscode.action 'workbench.action.files.save'
end)

vim.keymap.set('n', '<Leader>q', function()
  vscode.action 'workbench.action.closeWindow'
end)
vim.keymap.set('n', '<Leader>w', function()
  vscode.action 'workbench.action.files.save'
end)
vim.keymap.set('n', '<Leader>n', function()
  vscode.action 'welcome.showNewFileEntries'
end)

-- splits navigation
vim.keymap.set('n', '|', function()
  vscode.action 'workbench.action.splitEditor'
end)
vim.keymap.set('n', '\\', function()
  vscode.action 'workbench.action.splitEditorDown'
end)
vim.keymap.set('n', '<C-H>', function()
  vscode.action 'workbench.action.navigateLeft'
end)
vim.keymap.set('n', '<C-J>', function()
  vscode.action 'workbench.action.navigateDown'
end)
vim.keymap.set('n', '<C-K>', function()
  vscode.action 'workbench.action.navigateUp'
end)
vim.keymap.set('n', '<C-L>', function()
  vscode.action 'workbench.action.navigateRight'
end)

-- terminal
vim.keymap.set('n', '<F7>', function()
  vscode.action 'workbench.action.terminal.toggleTerminal'
end)
vim.keymap.set('n', "<C-'>", function()
  vscode.action 'workbench.action.terminal.toggleTerminal'
end)

-- buffer management
vim.keymap.set('n', ']b', '<Cmd>Tabnext<CR>')
vim.keymap.set('n', '[b', '<Cmd>Tabprevious<CR>')
vim.keymap.set('n', '<Leader>c', '<Cmd>Tabclose<CR>')
vim.keymap.set('n', '<Leader>C', '<Cmd>Tabclose!<CR>')
vim.keymap.set('n', '<Leader>bp', '<Cmd>Tablast<CR>')

-- file explorer
vim.keymap.set('n', '<Leader>e', function()
  vscode.action 'workbench.files.action.focusFilesExplorer'
end)
vim.keymap.set('n', '<Leader>o', function()
  vscode.action 'workbench.files.action.focusFilesExplorer'
end)

-- indentation
vim.keymap.set('v', '<Tab>', function()
  vscode.action 'editor.action.indentLines'
end)
vim.keymap.set('v', '<S-Tab>', function()
  vscode.action 'editor.action.outdentLines'
end)

-- diagnostics
vim.keymap.set('n', ']d', function()
  vscode.action 'editor.action.marker.nextInFiles'
end)
vim.keymap.set('n', '[d', function()
  vscode.action 'editor.action.marker.prevInFiles'
end)

-- pickers (emulate telescope mappings)
vim.keymap.set('n', '<Leader>fc', function()
  vscode.action('workbench.action.findInFiles', { args = { query = vim.fn.expand '<cword>' } })
end)
vim.keymap.set('n', '<Leader>fC', function()
  vscode.action 'workbench.action.showCommands'
end)
vim.keymap.set('n', '<Leader>ff', function()
  vscode.action 'workbench.action.quickOpen'
end)
vim.keymap.set('n', '<Leader>fn', function()
  vscode.action 'notifications.showList'
end)
vim.keymap.set('n', '<Leader>fo', function()
  vscode.action 'workbench.action.openRecent'
end)
vim.keymap.set('n', '<Leader>ft', function()
  vscode.action 'workbench.action.selectTheme'
end)
vim.keymap.set('n', '<Leader>fw', function()
  vscode.action 'workbench.action.findInFiles'
end)

-- git client
vim.keymap.set('n', '<Leader>gg', function()
  vscode.action 'workbench.view.scm'
end)

-- LSP Mappings
vim.keymap.set('n', 'K', function()
  vscode.action 'editor.action.showHover'
end)
vim.keymap.set('n', 'gI', function()
  vscode.action 'editor.action.goToImplementation'
end)
vim.keymap.set('n', 'gd', function()
  vscode.action 'editor.action.revealDefinition'
end)
vim.keymap.set('n', 'gD', function()
  vscode.action 'editor.action.revealDeclaration'
end)
vim.keymap.set('n', 'gr', function()
  vscode.action 'editor.action.goToReferences'
end)
vim.keymap.set('n', 'gy', function()
  vscode.action 'editor.action.goToTypeDefinition'
end)
vim.keymap.set('n', '<Leader>la', function()
  vscode.action 'editor.action.quickFix'
end)
vim.keymap.set('n', '<Leader>lG', function()
  vscode.action 'workbench.action.showAllSymbols'
end)
vim.keymap.set('n', '<Leader>lR', function()
  vscode.action 'editor.action.goToReferences'
end)
vim.keymap.set('n', '<Leader>lr', function()
  vscode.action 'editor.action.rename'
end)
vim.keymap.set('n', '<Leader>ls', function()
  vscode.action 'workbench.action.gotoSymbol'
end)
vim.keymap.set('n', '<Leader>lf', function()
  vscode.action 'editor.action.formatDocument'
end)

-- harpoon
vim.keymap.set('n', '<leader>ae', function()
  vscode.action 'vscode-harpoon.addEditor'
end)
vim.keymap.set('n', '<leader>e', function()
  vscode.action 'vscode-harpoon.editEditors'
end)
vim.keymap.set('n', '<leader>pe', function()
  vscode.action 'vscode-harpoon.editorQuickPick'
end)

vim.keymap.set('n', '<leader>1', function()
  vscode.action 'vscode-harpoon.gotoEditor1'
end)
vim.keymap.set('n', '<leader>2', function()
  vscode.action 'vscode-harpoon.gotoEditor2'
end)
vim.keymap.set('n', '<leader>3', function()
  vscode.action 'vscode-harpoon.gotoEditor3'
end)
vim.keymap.set('n', '<leader>4', function()
  vscode.action 'vscode-harpoon.gotoEditor4'
end)
vim.keymap.set('n', '<leader>5', function()
  vscode.action 'vscode-harpoon.gotoEditor5'
end)
vim.keymap.set('n', '<leader>6', function()
  vscode.action 'vscode-harpoon.gotoEditor6'
end)
vim.keymap.set('n', '<leader>7', function()
  vscode.action 'vscode-harpoon.gotoEditor7'
end)
vim.keymap.set('n', '<leader>8', function()
  vscode.action 'vscode-harpoon.gotoEditor8'
end)
vim.keymap.set('n', '<leader>9', function()
  vscode.action 'vscode-harpoon.gotoEditor9'
end)

vim.keymap.set('n', '<leader>a1', function()
  vscode.action 'vscode-harpoon.addEditor1'
end)
vim.keymap.set('n', '<leader>a2', function()
  vscode.action 'vscode-harpoon.addEditor2'
end)
vim.keymap.set('n', '<leader>a3', function()
  vscode.action 'vscode-harpoon.addEditor3'
end)
vim.keymap.set('n', '<leader>a4', function()
  vscode.action 'vscode-harpoon.addEditor4'
end)
vim.keymap.set('n', '<leader>a5', function()
  vscode.action 'vscode-harpoon.addEditor5'
end)
vim.keymap.set('n', '<leader>a6', function()
  vscode.action 'vscode-harpoon.addEditor6'
end)
vim.keymap.set('n', '<leader>a7', function()
  vscode.action 'vscode-harpoon.addEditor7'
end)
vim.keymap.set('n', '<leader>a8', function()
  vscode.action 'vscode-harpoon.addEditor8'
end)
vim.keymap.set('n', '<leader>a9', function()
  vscode.action 'vscode-harpoon.addEditor9'
end)

-- https://github.com/vscode-neovim/vscode-neovim/issues/1624
-- https://github.com/vscode-neovim/vscode-neovim?tab=readme-ov-file#vscodeactionname-opts
-- https://www.lazyvim.org/extras/vscode
-- https://stackoverflow.com/questions/58367207/list-of-all-available-commands-in-vscode
-- https://medium.com/@shaikzahid0713/integrate-neovim-inside-vscode-5662d8855f9d
-- https://marketplace.visualstudio.com/items?itemName=tobias-z.vscode-harpoon
