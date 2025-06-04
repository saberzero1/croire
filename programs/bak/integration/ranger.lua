-- https://github.com/kevinhwang91/rnvimr
-- https://github.com/VardanHeroic/ranger.nvim
local keymap = require('scripts.keymap').ranger

---@type LazySpec
return {
  'kelly-lin/ranger.nvim',
  config = function()
    require('ranger-nvim').setup { replace_netrw = true }
    --[[vim.api.nvim_set_keymap("n", "<leader>o", "", {
      desc = "[o]pen Ranger",
      noremap = true,
      callback = function()
        require("ranger-nvim").open(true)
      end,
    })]]
    --
  end,
  keys = keymap,
}
