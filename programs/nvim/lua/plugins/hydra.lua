---@type LazySpec
return {
  'nvimtools/hydra.nvim',
  enabled = false,
  depends = {
    'folke/which-key.nvim',
    'folke/snacks.nvim',
    'folke/trouble.nvim',
    'lewis6991/gitsigns.nvim',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'akinsho/bufferline.nvim',
    'folke/todo-comments.nvim',
    'gbprod/yanky.nvim',
  },
  config = function()
    -- Initialize the plugin
    local Hydra = require 'hydra'
    local util = require 'hydra.statusline'
    -- local Layer = require 'hydra.layer'
    Hydra.setup {
      color = 'pink',
    }
  end,
}
