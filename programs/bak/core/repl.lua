-- Can run repl in a floating window
-- https://github.com/pappasam/nvim-repl/blob/main/images/nvim-repl-demo.gif
--
-- TODO: Implement magma.nvim
-- https://github.com/dccsillag/magma-nvim
local keymap = require('scripts.keymap').repl

---@type LazySpec
return {
  'pappasam/nvim-repl',
  lazy = false,
  init = function()
    vim.g['repl_filetype_commands'] = {
      javascript = 'node',
      python = 'ipython --no-autoindent',
    }
  end,
  keys = keymap,
}
