---@type LazySpec
return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local harpoon = require 'harpoon'
    local term_string = vim.fn.exists '$TMUX' == 1 and 'tmux' or 'term'

    -- https://github.com/ThePrimeagen/harpoon/tree/harpoon2?tab=readme-ov-file#harpoonsetup-is-required
    -- Autocmds setup
    harpoon:setup()

    -- Keybindings
    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = '[h]arpoon [a]dd file' })
    -- vim.keymap.set("n", "<leader>he", function() harpoon:list():toggle_quick_menu() end, { desc = "[h]arpoon [e]nable/disable quick menu" })
    vim.keymap.set('n', '<leader>he', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = '[h]arpoon [e]nable/disable quick menu' })
    vim.keymap.set('n', '<C-x>', function()
      vim.ui.input({ prompt = 'Harpoon mark index: ' }, function(input)
        local num = tonumber(input)
        if num then
          harpoon:list():select(num)
        end
      end)
    end, { desc = 'Goto index of mark' })

    -- Marks navigation
    vim.keymap.set('n', '<leader>p', function()
      harpoon:list():prev()
    end, { desc = '[p]revious mark' })
    vim.keymap.set('n', '<C-S-P>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<leader>n', function()
      harpoon:list():next()
    end, { desc = '[n]ext mark' })
    vim.keymap.set('n', '<C-S-N>', function()
      harpoon:list():next()
    end)
    vim.keymap.set('n', '<leader>ht', function()
      vim.ui.input({ prompt = term_string .. ' window number: ' }, function(input)
        local num = tonumber(input)
        if num then
          harpoon.term.gotoTerminal(num)
        end
      end)
    end, { desc = 'Go to ' .. term_string .. ' window' })

    -- Telescope configuration
    local telescope_config = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = telescope_config.file_previewer {},
          sorter = telescope_config.generic_sorter {},
        })
        :find()
    end

    vim.keymap.set('n', '<leader>sm', function()
      toggle_telescope(harpoon:list())
    end, { desc = '[s]earch [m]arks Telescope' })
  end,
}
