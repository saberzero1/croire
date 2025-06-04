local keylist = {}

keylist.copilot = {
  ['<leader>'] = {
    ['C'] = {
      ['opts'] = { { group = '[C]opilot', mode = { 'n', 'v' } } },
      -- Authenticate
      ['l'] = {
        function()
          copilot_command 'auth signin'
        end,
        { desc = '[l]ogin' },
      },
      ['L'] = {
        function()
          copilot_command 'auth signout'
        end,
        { desc = '[L]ogin' },
      },

      -- Enable/Disable autotrigger
      ['t'] = {
        function()
          copilot_command 'suggestion toggle_auto_trigger'
        end,
        { desc = '[t]oggle' },
      },
      ['e'] = {
        function()
          copilot_command 'enable'
        end,
        { desc = '[e]nable' },
      },
      ['d'] = {
        function()
          copilot_command 'disable'
        end,
        { desc = '[d]isable' },
      },

      -- Panel
      ['p'] = {
        ['opts'] = { { group = '[p]anel', mode = { 'n', 'v' } } },
        ['o'] = {
          function()
            copilot_command 'panel open'
          end,
          { desc = '[o]pen' },
        },
        ['r'] = {
          function()
            copilot_command 'panel refresh'
          end,
          { desc = '[r]efresh' },
        },
        ['a'] = {
          function()
            copilot_command 'panel accept'
          end,
          { desc = '[a]ccept' },
        },
        ['n'] = {
          function()
            copilot_command 'panel jump_next'
          end,
          { desc = '[n]ext' },
        },
        ['p'] = {
          function()
            copilot_command 'panel jump_prev'
          end,
          { desc = '[p]rev' },
        },
      },

      -- Status
      ['s'] = {
        function()
          copilot_command 'status'
        end,
        { desc = '[s]tatus' },
      },
    },
  },
}

keylist.diffview = {
  ['<leader>'] = {
    ['g'] = {
      ['d'] = {
        ['opts'] = { { group = '[d]iff', mode = { 'n', 'v' } } },
        ['c'] = {
          function()
            vim.api.nvim_command 'DiffviewClose'
          end,
          { desc = '[c]lose' },
        },
        ['f'] = {
          function()
            vim.api.nvim_command 'DiffviewFocusFiles'
          end,
          { desc = '[f]ocus' },
        },
        ['h'] = {
          function()
            vim.api.nvim_command 'DiffviewFileHistory'
          end,
          { desc = '[h]istory' },
        },
        ['n'] = {
          function()
            require('diffview').next()
          end,
          { desc = '[n]ext' },
        },
        ['o'] = {
          function()
            vim.api.nvim_command 'DiffviewOpen'
          end,
          { desc = '[o]pen' },
        },
        ['p'] = {
          function()
            require('diffview').prev()
          end,
          { desc = '[p]revious' },
        },
        ['r'] = {
          function()
            vim.api.nvim_command 'DiffviewRefresh'
          end,
          { desc = '[r]efresh' },
        },
        ['t'] = {
          function()
            vim.api.nvim_command 'DiffviewToggleFiles'
          end,
          { desc = '[t]oggle' },
        },
      },
    },
  },
}

keylist.fugitive = {
  ['<leader>'] = {
    ['g'] = {
      ['opts'] = { { group = '[g]it', mode = { 'n', 'v' } } },
      ['a'] = {
        function()
          Git:add()
        end,
        { desc = '[a]dd' },
      },
      ['b'] = {
        function()
          Git:branch()
        end,
        { desc = '[b]ranch' },
      },
      ['c'] = {
        function()
          Git:checkout()
        end,
        { desc = '[c]heckout' },
      },
      ['f'] = {
        function()
          Git:fetch()
        end,
        { desc = '[f]etch' },
      },
      ['F'] = {
        function()
          Git:fetch 'all'
        end,
        { desc = '[F]etch all' },
      },
      ['i'] = {
        function()
          Git:init()
        end,
        { desc = '[i]nit' },
      },
      ['I'] = {
        function()
          Git:init 'bare'
        end,
        { desc = '[I]nit bare' },
      },
      ['p'] = {
        function()
          Git:pull()
        end,
        { desc = '[p]ull' },
      },
      ['P'] = {
        function()
          Git:push()
        end,
        { desc = '[P]ush' },
      },
      ['l'] = {
        ['opts'] = { { group = '[l]ist', mode = { 'n', 'v' } } },
        ['b'] = {
          ['opts'] = { { group = '[b]ranch', mode = { 'n', 'v' } } },
          ['a'] = {
            function()
              Git:branch '-a'
            end,
            { desc = '[a]ll' },
          },
          ['r'] = {
            function()
              Git:branch '-r'
            end,
            { desc = '[r]emote' },
          },
          ['l'] = {
            function()
              Git:branch()
            end,
            { desc = '[l]ocal' },
          },
        },
        ['c'] = {
          ['opts'] = { { group = '[c]onfig', mode = { 'n', 'v' } } },
          ['g'] = {
            ['opts'] = { { group = '[g]lobal', mode = { 'n', 'v' } } },
            ['c'] = {
              function()
                Git:config_get()
              end,
              { desc = '[c]onfig' },
            },
            ['e'] = {
              function()
                Git:config_get 'user.email'
              end,
              { desc = '[e]mail' },
            },
            ['n'] = {
              function()
                Git:config_get 'user.name'
              end,
              { desc = '[n]ame' },
            },
          },
          ['l'] = {
            ['opts'] = { { group = '[l]ocal', mode = { 'n', 'v' } } },
            ['c'] = {
              function()
                Git:config_get(nil, 'local')
              end,
              { desc = '[c]onfig' },
            },
            ['e'] = {
              function()
                Git:config_get('user.email', 'local')
              end,
              { desc = '[e]mail' },
            },
            ['n'] = {
              function()
                Git:config_get('user.name', 'local')
              end,
              { desc = '[n]ame' },
            },
          },
        },
      },
      ['s'] = {
        function()
          Git:status()
        end,
        { desc = '[s]tatus' },
      },
      ['S'] = {
        function()
          Git:stash()
        end,
        { desc = '[S]tash' },
      },
      ['?'] = {
        ['opts'] = { { group = '[?] Config', mode = { 'n', 'v' } } },
        ['g'] = {
          ['opts'] = { { group = '[g]lobal', mode = { 'n', 'v' } } },
          ['e'] = {
            function()
              Git:config_set('user.email', nil)
            end,
            { desc = '[e]mail' },
          },
          ['l'] = {
            function()
              Git:config_get()
            end,
            { desc = '[l]ist' },
          },
          ['n'] = {
            function()
              Git:config_set('user.name', nil)
            end,
            { desc = '[n]ame' },
          },
        },
        ['l'] = {
          ['opts'] = { { group = '[l]ocal', mode = { 'n', 'v' } } },
          ['e'] = {
            function()
              Git:config_set('user.email', nil, 'local')
            end,
            { desc = '[e]mail' },
          },
          ['l'] = {
            function()
              Git:config_get(nil, 'local')
            end,
            { desc = '[l]ist' },
          },
          ['n'] = {
            function()
              Git:config_set('user.name', nil, 'local')
            end,
            { desc = '[n]ame' },
          },
        },
      },
      ['/'] = {
        function()
          Git:grep()
        end,
        { desc = '[/] Grep' },
      },
    },
  },
}

keylist.harpoon = {
  ['<leader>'] = {
    ['h'] = {
      ['opts'] = { { group = '[h]arpoon', mode = { 'n', 'v' } } },
      ['a'] = {
        function()
          require('harpoon'):list():add()
        end,
        { desc = '[a]dd' },
      },
    },
    ['1'] = {
      function()
        require('harpoon'):list():select(1)
      end,
      { desc = '[1] Harpoon' },
    },
    ['2'] = {
      function()
        require('harpoon'):list():select(2)
      end,
      { desc = '[2] Harpoon' },
    },
    ['3'] = {
      function()
        require('harpoon'):list():select(3)
      end,
      { desc = '[3] Harpoon' },
    },
    ['4'] = {
      function()
        require('harpoon'):list():select(4)
      end,
      { desc = '[4] Harpoon' },
    },
    ['5'] = {
      function()
        require('harpoon'):list():select(5)
      end,
      { desc = '[5] Harpoon' },
    },
    ['6'] = {
      function()
        require('harpoon'):list():select(6)
      end,
      { desc = '[6] Harpoon' },
    },
    ['7'] = {
      function()
        require('harpoon'):list():select(7)
      end,
      { desc = '[7] Harpoon' },
    },
    ['8'] = {
      function()
        require('harpoon'):list():select(8)
      end,
      { desc = '[8] Harpoon' },
    },
    ['9'] = {
      function()
        require('harpoon'):list():select(9)
      end,
      { desc = '[9] Harpoon' },
    },
  },
}

keylist.ranger = {
  ['<leader>'] = {
    ['e'] = {
      ['opts'] = { { group = '[e]xplorer', mode = { 'n', 'v' } } },
      ['r'] = {
        function()
          require('ranger-nvim').open(true)
        end,
        { desc = '[r]anger', noremap = true },
      },
    },
  },
}

keylist.repl = {
  ['<leader>'] = {
    ['R'] = {
      ['opts'] = { { group = '[R]EPL', mode = { 'n', 'v' } } },
      ['t'] = {
        function()
          vim.api.nvim_command 'ReplToggle'
        end,
        { desc = '[t]oggle REPL', noremap = true, silent = true },
      },
      ['c'] = {
        function()
          vim.api.nvim_command 'ReplRunCell'
        end,
        { desc = 'Run [c]ell' },
      },
      ['l'] = {
        function()
          vim.api.nvim_command 'ReplSendLine'
        end,
        { desc = 'Run [l]ine' },
      },
      ['s'] = {
        function()
          vim.api.nvim_command 'ReplSendVisual'
        end,
        { desc = 'Run [s]election', mode = { 'n', 'v' } },
      },
      ['v'] = {
        function()
          vim.api.nvim_command 'ReplSendVisual'
        end,
        { desc = 'Run [v]isual', mode = { 'n', 'v' } },
      },
      ['o'] = {
        function()
          vim.api.nvim_command 'ReplOpen'
        end,
        { desc = '[o]pen REPL' },
      },
      ['q'] = {
        function()
          vim.api.nvim_command 'ReplClose'
        end,
        { desc = '[q]uit REPL' },
      },
    },
  },
}

keylist.spectre = {
  ['<leader>'] = {
    ['r'] = {
      ['opts'] = { { group = '[r]eplace', mode = { 'n', 'v' } } },
      ['f'] = {
        function()
          require('spectre').toggle()
        end,
        { desc = 'Current [f]ile' },
      },
      ['r'] = {
        function()
          require('spectre').open_visual { select_word = true }
        end,
        { desc = '[r]eplace in Files' },
      },
      ['w'] = {
        function()
          require('spectre').open_file_search { select_word = true }
        end,
        { desc = 'Selected [w]ord' },
      },
    },
  },
}

keylist.telescope = {
  ['<leader>'] = {
    ['<leader>'] = { builtin.buffers, { desc = '[ ] find existing buffers' } },
    ['/'] = {
      function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false })
      end,
      { desc = '[/] Fuzzily search in current buffer' },
    },
    ['s'] = {
      ['opts'] = { { group = '[s]earch', mode = { 'n', 'v' } } },
      ['d'] = { builtin.diagnostics, { desc = '[d]iagnostics' } },
      ['f'] = { builtin.find_files, { desc = '[f]iles' } },
      ['g'] = { builtin.live_grep, { desc = '[g]rep' } },
      ['h'] = { builtin.help_tags, { desc = '[h]elp' } },
      ['k'] = { builtin.keymaps, { desc = '[k]eymaps' } },
      ['n'] = {
        function()
          builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end,
        { desc = '[n]eovim files' },
      },
      ['r'] = { builtin.resume, { desc = '[r]esume' } },
      ['s'] = { builtin.builtin, { desc = '[s]elect Telescope' } },
      ['w'] = { builtin.grep_string, { desc = 'current [w]ord' } },
      ['.'] = { builtin.oldfiles, { desc = 'Recent Files ("." for repeat)' } },
      ['/'] = {
        function()
          builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
        end,
        { desc = '[/] Grep in Open Files' },
      },
    },
  },
}

return keylist
