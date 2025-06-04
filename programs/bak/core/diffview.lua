local keymap = require('scripts.keymap').diffview

---@type LazySpec
return {
  'sindrets/diffview.nvim',
  event = 'VimEnter',
  config = function()
    require('diffview').setup()
  end,
  keys = keymap,
}
