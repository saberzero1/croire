-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Less verbose config
--[[local key = function(mode, sequence, action, params)
  params = params or {}
  vim.keymap.set(mode, sequence, action, params)
end]]
--

local key_nvim = function(mode, sequence, action, params)
  params = params or {}
  vim.api.nvim_set_keymap(mode, sequence, action, params)
end

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
--key('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
--key('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
--key('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
--key('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
--key('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
--key('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
--key('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Set H/L to start/end of line (ignoring whitespaces)
--vim.keymap.set('n', 'H', '^', { desc = 'Move to first non-blank character of the line' })
--vim.keymap.set('n', 'L', 'g_', { desc = 'Move to last non-blank character of the line' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
--key('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
--key('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
--key('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
--key('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--[[if vim.g.neovide then
  key("n", "<C-s>", ":w<CR>") -- Save
  key("v", "<C-c>", '"+y') -- Copy
  key("n", "<C-v>", '"+P') -- Paste normal mode
  key("v", "<C-v>", '"+P') -- Paste visual mode
  key("c", "<C-v>", "<C-R>+") -- Paste command mode
  key("i", "<C-v>", '<ESC>l"+Pli') -- Paste insert mode
end]]
--

-- Allow clipboard copy paste in neovim
key_nvim('', '<C-v>', '+p<CR>', { noremap = true, silent = true })
key_nvim('!', '<C-v>', '<C-R>+', { noremap = true, silent = true })
key_nvim('t', '<C-v>', '<C-R>+', { noremap = true, silent = true })
key_nvim('v', '<C-v>', '<C-R>+', { noremap = true, silent = true })
