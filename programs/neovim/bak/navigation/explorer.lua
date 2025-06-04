-- https://github.com/simonmclean/triptych.nvim
local shared = require 'scripts.shared'
local git_sign_icons = shared:git_signs()
local explorer_icons = shared:explorer_icons()

---@type LazySpec
return {
  'simonmclean/triptych.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'nvim-tree/nvim-web-devicons', -- optional
  },
  config = function()
    require 'triptych'.setup({
      mappings = {
        -- Everything below is buffer-local, meaning it will only apply to Triptych windows
        show_help = 'g?',
        jump_to_cwd = '.',  -- Pressing again will toggle back
        nav_left = 'h',
        nav_right = { 'l', '<CR>' }, -- If target is a file, opens the file in-place
        open_hsplit = { '-' },
        open_vsplit = { '|' },
        open_tab = { '<C-t>' },
        cd = '<leader>cd',
        delete = 'd',
        add = 'a',
        copy = 'c',
        rename = 'r',
        cut = 'x',
        paste = 'p',
        quit = 'q',
        toggle_hidden = '<leader>.',
        toggle_collapse_dirs = 'z',
      },
      extension_mappings = {},
      options = {
        dirs_first = true,
        show_hidden = true,
        collapse_dirs = true,
        line_numbers = {
          enabled = true,
          relative = true,
        },
        file_icons = {
          enabled = true,
          directory_icon = explorer_icons.directory,
          fallback_file_icon = explorer_icons.file,
        },
        responsive_column_widths = {
          -- Keys are breakpoints, values are column widths
          -- A breakpoint means "when vim.o.columns >= x, use these column widths"
          -- Columns widths must add up to 1 after rounding to 2 decimal places
          -- Parent or child windows can be hidden by setting a width of 0
          ['0'] = { 0, 0.5, 0.5 },
          ['120'] = { 0.2, 0.3, 0.5 },
          ['200'] = { 0.25, 0.25, 0.5 },
        },
        highlights = { -- Highlight groups to use. See `:highlight` or `:h highlight`
          file_names = 'NONE',
          directory_names = 'NONE',
        },
        syntax_highlighting = { -- Applies to file previews
          enabled = true,
          debounce_ms = 100,
        },
        backdrop = 60, -- Backdrop opacity. 0 is fully opaque, 100 is fully transparent (disables the feature)
        border = 'single', -- See :h nvim_open_win for border options
        max_height = 45,
        max_width = 220,
        margin_x = 4, -- Space left and right
        margin_y = 4, -- Space above and below
      },
      git_signs = {
        enabled = true,
        signs = {
          -- The value can be either a string or a table.
          -- If a string, will be basic text. If a table, will be passed as the {dict} argument to vim.fn.sign_define
          -- If you want to add color, you can specify a highlight group in the table.
          add = git_sign_icons.add,
          modify = git_sign_icons.change,
          rename = git_sign_icons.rename,
          untracked = git_sign_icons.untracked,
        },
      },
      diagnostic_signs = {
        enabled = true,
      },
    })
    vim.keymap.set('n', '<leader>-', ':Triptych<CR>', { silent = true })
  end,
}
