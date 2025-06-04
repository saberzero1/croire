if not vim.g.vscode then
  return {}
end -- don't do anything in non-vscode instances

local enabled = {}
vim.tbl_map(function(plugin)
  enabled[plugin] = true
end, {
  -- core plugins
  'lazy.nvim',
  'Comment.nvim',
  'nvim-autopairs',
  'nvim-treesitter',
  'nvim-ts-autotag',
  'nvim-treesitter-textobjects',
  'nvim-ts-context-commentstring',
  -- more known working
  'dial.nvim',
  'flash.nvim',
  'flit.nvim',
  'leap.nvim',
  'mini.ai',
  'mini.comment',
  'mini.move',
  'mini.pairs',
  'mini.surround',
  'ts-comments.nvim',
  'vim-easy-align',
  'vim-repeat',
  'vim-sandwich',
  'yanky.nvim',
  -- feel free to open PRs to add more support!
})

local Config = require 'lazy.core.config'
-- disable plugin update checking
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
-- replace the default `cond`
Config.options.defaults.cond = function(plugin)
  return enabled[plugin.name]
end

local vscode = require 'vscode'

---@type LazySpec
return {
  {
    --[[opts = {
    },
    keys = {
      {
        "<leader>q",
        function() vscode.action 'workbench.action.closeWindow' end,
      },

      {
        "<leader>w",
        function() vscode.action 'workbench.action.files.save' end,
      },


      {
        "<Leader>q",
        function() vscode.action 'workbench.action.closeWindow' end,
      },

      {
        "<Leader>w",
        function() vscode.action 'workbench.action.files.save' end,
      },

      {
        "<Leader>n",
        function() vscode.action 'welcome.showNewFileEntries' end,
      },


-- splits navigation
      {
        "|",
        function() vscode.action 'workbench.action.splitEditor' end,
      },

      {
        "\\",
        function() vscode.action 'workbench.action.splitEditorDown' end,
      },

      {
        "<C-H>",
        function() vscode.action 'workbench.action.navigateLeft' end,
      },

      {
        "<C-J>",
        function() vscode.action 'workbench.action.navigateDown' end,
      },

      {
        "<C-K>",
        function() vscode.action 'workbench.action.navigateUp' end,
      },

      {
        "<C-L>",
        function() vscode.action 'workbench.action.navigateRight' end,
      },


-- terminal
      {
        "<F7>",
        function() vscode.action 'workbench.action.terminal.toggleTerminal' end,
      },

      {
        "<C-'>",
        function() vscode.action 'workbench.action.terminal.toggleTerminal' end,
      },


-- buffer management
      {
        "]b",
        "<Cmd>Tabnext<CR>",
      },
      {
        "[b",
        "<Cmd>Tabprevious<CR>",
      },
      {
        "<Leader>c",
        "<Cmd>Tabclose<CR>",
      },
      {
        "<Leader>C",
        "<Cmd>Tabclose!<CR>",
      },
      {
        "<Leader>bp",
        "<Cmd>Tablast<CR>",
      },

-- file explorer
      {
        "<Leader>e",
        function() vscode.action 'workbench.files.action.focusFilesExplorer' end,
      },

      {
        "<Leader>o",
        function() vscode.action 'workbench.files.action.focusFilesExplorer' end,
      },


-- indentation
      {
        "<Tab>",
        function() vscode.action 'editor.action.indentLines' end,
      },

      {
        "<S-Tab>",
        function() vscode.action 'editor.action.outdentLines' end,
      },


-- diagnostics
      {
        "]d",
        function() vscode.action 'editor.action.marker.nextInFiles' end,
      },

      {
        "[d",
        function() vscode.action 'editor.action.marker.prevInFiles' end,
      },


-- pickers (emulate telescope mappings)
      {
        "<Leader>fc",
        function() vscode.action('workbench.action.findInFiles', { args = { query = vim.fn.expand '<cword>' } }) end,
      },

      {
        "<Leader>fC",
        function() vscode.action 'workbench.action.showCommands' end,
      },

      {
        "<Leader>ff",
        function() vscode.action 'workbench.action.quickOpen' end,
      },

      {
        "<Leader>fn",
        function() vscode.action 'notifications.showList' end,
      },

      {
        "<Leader>fo",
        function() vscode.action 'workbench.action.openRecent' end,
      },

      {
        "<Leader>ft",
        function() vscode.action 'workbench.action.selectTheme' end,
      },

      {
        "<Leader>fw",
        function() vscode.action 'workbench.action.findInFiles' end,
      },


-- git client
      {
        "<Leader>gg",
        function() vscode.action 'workbench.view.scm' end,
      },


-- LSP Mappings
      {
        "K",
        function() vscode.action 'editor.action.showHover' end,
      },

      {
        "gI",
        function() vscode.action 'editor.action.goToImplementation' end,
      },

      {
        "gd",
        function() vscode.action 'editor.action.revealDefinition' end,
      },

      {
        "gD",
        function() vscode.action 'editor.action.revealDeclaration' end,
      },

      {
        "gr",
        function() vscode.action 'editor.action.goToReferences' end,
      },

      {
        "gy",
        function() vscode.action 'editor.action.goToTypeDefinition' end,
      },

      {
        "<Leader>la",
        function() vscode.action 'editor.action.quickFix' end,
      },

      {
        "<Leader>lG",
        function() vscode.action 'workbench.action.showAllSymbols' end,
      },

      {
        "<Leader>lR",
        function() vscode.action 'editor.action.goToReferences' end,
      },

      {
        "<Leader>lr",
        function() vscode.action 'editor.action.rename' end,
      },

      {
        "<Leader>ls",
        function() vscode.action 'workbench.action.gotoSymbol' end,
      },

      {
        "<Leader>lf",
        function() vscode.action 'editor.action.formatDocument' end,
      },
    },]]--
  },
  -- disable treesitter highlighting
  { 'nvim-treesitter/nvim-treesitter', opts = { highlight = { enable = false } } },
}
