local enabled = false
if not enabled then
  return
end

local ok_hydra, Hydra = pcall(require, 'hydra')
if not ok_hydra then
  vim.notify('hydra not installed...', vim.log.ERROR)
  return
end

-- Set up layers
local M = {} -- modes

-- External keymaps
-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end
-- Treesitter textobjects
local treesitter_move = require 'nvim-treesitter.configs'.setup {
  textobjects = {
    move = {
      enable = true,
    },
  },
}
-- Git Signs
local gs = package.loaded.gitsigns

-- Set up heads
M.jump_prev_hydra = Hydra {
  name = 'Hydra Jumper',
  mode = { 'n', 'x' },
  hint = [[ Jumper Hydra ]],
  body = '[',
  config = {
    hint = true,
    invoke_on_body = true,
  },
  heads = {
    { '<Esc>', nil, { private = true, exit = true, desc = 'Exit Hydra' } },
    {
      'a',
      function()
        treesitter_move.goto_previous_start('@parameter.inner')
      end,
      { private = true, desc = 'Goto previous start @parameter.inner' },
    },
    { 
      'A',
      function()
        treesitter_move.goto_previous_end('@parameter.inner')
      end,
      { private = true, desc = 'Goto previous end @parameter.inner' },
    },
    {
      'c',
      function()
        treesitter_move.goto_previous_start('@class.outer')
      end,
      { private = true, desc = 'Goto previous start @class.outer' },
    },
    {
      'C',
      function()
        treesitter_move.goto_previous_end('@class.outer')
      end,
      { private = true, desc = 'Goto previous end @class.outer' },
    },
    {
      'f',
      function()
        treesitter_move.goto_previous_start('@function.outer')
      end,
      { private = true, desc = 'Goto previous start @function.outer' },
    },
    {
      'F',
      function()
        treesitter_move.goto_previous_end('@function.outer')
      end,
      { private = true, desc = 'Goto previous end @function.outer' },
    },
    {
      'h',
      function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gs.nav_hunk 'prev'
        end
      end,
      { private = true, desc = 'Prev Hunk' },
    },
    {
      'H',
      function()
        gs.nav_hunk 'first'
      end,
      { private = true, desc = 'First Hunk' },
    },
    {
      '[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      { private = true, desc = 'Prev Reference' },
    },
    { 'b', '<cmd>BufferLineCyclePrev<cr>', { private = true, desc = 'Prev Buffer' } },
    { 'B', '<cmd>BufferLineMovePrev<cr>', { private = true, desc = 'Move buffer prev' } },
    { 'd', diagnostic_goto(false), { private = true, desc = 'Prev Diagnostic' } },
    { 'e', diagnostic_goto(false, 'ERROR'), { private = true, desc = 'Prev Error' } },
    { 'm', '[m', { private = true, desc = 'Previous method start' } },
    { 'M', '[M', { private = true, desc = 'Previous method end' } },
    { 'p', '<Plug>(YankyPutIndentBeforeLinewise)', { private = true, desc = 'Put Indented Before Cursor (Linewise)' } },
    { 'P', '<Plug>(YankyPutIndentBeforeLinewise)', { private = true, desc = 'Put Indented Before Cursor (Linewise)' } },
    {
      "q",
      function()
        if require("trouble").is_open() then
          require("trouble").prev({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      { private = true, desc = "Previous Trouble/Quickfix Item", },
    },
    -- s
    {
      't',
      function()
        require('todo-comments').jump_prev()
      end,
      { private = true, desc = 'Previous Todo Comment' },
    },
    { 'w', diagnostic_goto(false, 'WARN'), { private = true, desc = 'Prev Warning' } },
    { 'y', '<Plug>(YankyCycleForward)', { private = true, desc = 'Cycle Forward Through Yank History' } },
    { '%', '[%', { private = true, desc = 'Previous unmatched group' } },
    { '{', '[{', { private = true, desc = 'Previous {' } },
    { '(', '[(', { private = true, desc = 'Previous (' } },
    { '<', '[<', { private = true, desc = 'Previous <' } },
  },
}
 M.jump_next_hydra = Hydra {
  name = 'Hydra Jumper',
  mode = {'n', 'x'},
  hint = [[ Jumper Hydra ]],
  body = ']',
  config = {
    hint = true,
    invoke_on_body = true,
  },
  heads = {
    { '<Esc>', nil, { private = true, exit = true, desc = 'Exit Hydra' } },
    {
      'a',
      function()
        treesitter_move.goto_next_start('@parameter.inner')
      end,
      { private = true, desc = 'Goto next start @parameter.inner' },
    },
    {
      'A',
      function()
        treesitter_move.goto_next_end('@parameter.inner')
      end,
      { private = true, desc = 'Goto next end @parameter.inner' },
    },
    {
      'c',
      function()
        treesitter_move.goto_next_start('@class.outer')
      end,
      { private = true, desc = 'Goto next start @class.outer' },
    },
    {
      'C',
      function()
        treesitter_move.goto_next_end('@class.outer')
      end,
      { private = true, desc = 'Goto next end @class.outer' },
    },
    {
      'f',
      function()
        treesitter_move.goto_next_start('@function.outer')
      end,
      { private = true, desc = 'Goto next start @function.outer' },
    },
    {
      'F',
      function()
        treesitter_move.goto_next_end('@function.outer')
      end,
      { private = true, desc = 'Goto next end @function.outer' },
    },
    {
      'h',
      function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gs.nav_hunk 'next'
        end
      end,
      { private = true, desc = 'Next Hunk' },
    },
    {
      'H',
      function()
        gs.nav_hunk 'last'
      end,
      { private = true, desc = 'Last Hunk' },
    },
    {
      ']',
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      { private = true, desc = 'Next Reference' },
    },
    { 'b', '<cmd>BufferLineCycleNext<cr>', { private = true, desc = 'Next Buffer' } },
    { 'B', '<cmd>BufferLineMoveNext<cr>', { private = true, desc = 'Move buffer next' } },
    { 'd', diagnostic_goto(true), { private = true, desc = 'Next Diagnostic' } },
    { 'e', diagnostic_goto(true, 'ERROR'), { private = true, desc = 'Next Error' } },
    { 'm', ']m', { private = true, desc = 'Next method start' } },
    { 'M', ']M', { private = true, desc = 'Next method end' } },
    { 'p', '<Plug>(YankyPutIndentAfterLinewise)', { private = true, desc = 'Put Indented After Cursor (Linewise)' } },
    { 'P', '<Plug>(YankyPutIndentAfterLinewise)', { private = true, desc = 'Put Indented After Cursor (Linewise)' } },
    {
      "q",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      { private = true, desc = "Next Trouble/Quickfix Item", },
    },
    -- s
    {
      't',
      function()
        require('todo-comments').jump_next()
      end,
      { private = true, desc = 'Next Todo Comment' },
    },
    { 'w', diagnostic_goto(true, 'WARN'), { private = true, desc = 'Next Warning' } },
    { 'y', '<Plug>(YankyCycleBackward)', { private = true, desc = 'Cycle Backward Through Yank History' } },
    { '%', ']%', { private = true, desc = 'Next unmatched group' } },
    { '}', ']}', { private = true, desc = 'Next {' } },
    { ')', '])', { private = true, desc = 'Next (' } },
    { '>', ']>', { private = true, desc = 'Next <' } },
  },
}
 
return M

