---@type LazySpec
return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    local utils = require 'scripts.cursorline-gradients'

    local code_stats = function()
      --local init_code_stats = require('scripts.codestats.init_codestats')
      --if init_code_stats.codestats ~= nil then
        --print('pog')
        --return 'pog'
        --return init_code_stats.CodeStatsXp()
      --else
        --init_code_stats.init_codestats()
        --print('sadge')
        --return 'sadge'
      --end
      return 'pog'
    end

--[[    return {
      options = {
        component_separators = { left = " ", right = " " },
        section_separators = { left = " ", right = " " },
        theme = "cyberdream",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      },
      sections = {
        lualine_a = { { "mode", icon = "" } },
        lualine_b = {
          { "branch", icon = "" },
        },
        lualine_c = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          {
            'filename',
            padding = { left = 1, right = 0 },
            file_status = true,     -- Displays file status (readonly status, modified status)
            newfile_status = false, -- Display new file status (new file means no write after created)
            path = 1,               -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            -- 4: Filename and parent dir, with tilde as the home directory

            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
            -- for other components. (terrible name, any suggestions?)
            symbols = {
              modified = '[+]',      -- Text to show when the file is modified.
              readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]',     -- Text to show for newly created file before first write
            }
          }
        },
        lualine_x = {
          {
            "diagnostics",
            always_visible = false,
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = "󰝶 "
            },
          },
          { "diff" }
        },
        lualine_y = {
          {
            "progress",
          },
          {
            "location",
            color = utils.get_hlgroup("Boolean"),
          },
        },
        lualine_z = {},
      },
      extensions = { "lazy", "toggleterm", "mason", "neo-tree", "trouble" },
    }
  end,
}]]--
    local copilot_colors = {
      [''] = utils.get_hlgroup('Comment'),
      ['Active'] = utils.get_hlgroup('String'),
      ['Disabled'] = utils.get_hlgroup('Conceal'),
      ['Normal'] = utils.get_hlgroup('Comment'),
      ['Warning'] = utils.get_hlgroup('DiagnosticError'),
      ['InProgress'] = utils.get_hlgroup('DiagnosticWarn'),
    }
    --require('lualine').setup {
    return {

      options = {
        icons_enabled = true,
        theme = 'auto',
        --theme = 'cyberdream',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = { 'dashboard', 'alpha' },
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        --globalstatus = false,
        globalstatus = true,        
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename', 'harpoon2'},
        lualine_x = {        
          {
            'copilot',
            -- Default values
            symbols = {
              status = {
                icons = {
                  enabled = ' ',
                  sleep = ' ',   -- auto-trigger disabled
                  disabled = ' ',
                  warning = ' ',
                  unknown = ' '
                },
                hl = {
                  enabled = copilot_colors['Active'],
                  sleep = copilot_colors['Normal'],
                  disabled = copilot_colors['Disabled'],
                  warning = copilot_colors['Warning'],
                  unknown = copilot_colors['InProgress']
                }
              },
              spinners = require 'copilot-lualine.spinners'.dots,
              spinner_color = copilot_colors['InProgress'],
            },
            show_colors = true,
            show_loading = true
          }, 'encoding', 'fileformat', 'filetype'},
        lualine_y = {
          {
            'progress'
          },
          {
            'location',
            color = utils.get_hlgroup('Boolean'),
          },
        },
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = { 'lazy', 'toggleterm', 'mason', 'neo-tree', 'trouble' },
    }
  end,
}