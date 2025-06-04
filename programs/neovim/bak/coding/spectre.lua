local keymap = require 'scripts.keymap'.spectre

---@type LazySpec
return {
  'nvim-pack/nvim-spectre',
  build = false,
  cmd = 'Spectre',
  opts = { open_cmd = 'noswapfile vnew' },
  keys = keymap,
}
