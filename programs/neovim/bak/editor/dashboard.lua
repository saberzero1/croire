---@type LazySpec
return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require 'dashboard'.setup({
      theme = 'hyper',
      config = {
        week_header = {
         enable = true,
        },
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            desc = ' Grep',
            group = 'Label',
            action = 'Telescope live_grep',
            key = 'g',
          },
          {
            desc = ' Keymaps',
            group = 'Number',
            action = 'Telescope keymaps',
            key = 'm',
          },
        },
      },
    })
  end,
  dependencies = {
    {
      'nvim-tree/nvim-web-devicons',
    }
  },
}
