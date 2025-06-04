local keymap = require('scripts.keymap').fugitive

---@type LazySpec
return {
  'tpope/vim-fugitive',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  keys = keymap,
}
