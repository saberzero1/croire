---@type LazySpec
return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
  },
  keys = {
    { '<leader>e', '<cmd>Yazi<cr>', desc = 'Explorer Yazi (root dir)' },
    { '<leader>E', '<cmd>Yazi cwd<cr>', desc = 'Explorer Yazi (cwd)' },
  },
  ---@type YaziConfig | {}
  opts = {
    open_for_directories = true,
    keymaps = {
      show_help = '<f1>',
    },
  },
  init = function()
    vim.g.loaded_netrwPlugin = 1
  end,
}
