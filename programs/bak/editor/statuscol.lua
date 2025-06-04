---@type LazySpec
return {
  'luukvbaal/statuscol.nvim',
  dependencies = { 'lewis6991/gitsigns.nvim' },
  lazy = false,
  config = function()
    local builtin = require 'statuscol.builtin'
    require 'statuscol'.setup({
      setopt = false,
      bt_ignore = {'terminal', 'nofile'},
      relculright = true,
      segments = {
        {
          sign = {name = {'GitSigns'}, maxwidth = 2, colwidth = 1, auto = false, fillchar = ' '},
          click = 'v:lua.ScGa',
        },
        {
          sign = {name = {'Diagnostic'}, maxwidth = 2, colwidth = 1, auto = false, fillchar = ' '},
          click = 'v:lua.ScSa',
        },
        {
          sign = {name = {'.*'}, namespace = {'.*'}, maxwidth = 2, colwidth = 1, wrap = true, auto = false, fillchar = ' '},
          click = 'v:lua.ScSa',
        },
        {text = {builtin.foldfunc}, click = 'v:lua.ScFa'},
        {text = {builtin.lnumfunc}, click = 'v:lua.ScLa'},
        {text = {'┃'}, condition = {builtin.not_empty}},
      },
    })
  end,
}