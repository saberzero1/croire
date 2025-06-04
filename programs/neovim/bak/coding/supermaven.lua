local enabled = false

if not enabled then return {} end

--[[
Commands:

:SupermavenStart    start supermaven-nvim
:SupermavenStop     stop supermaven-nvim
:SupermavenRestart  restart supermaven-nvim
:SupermavenToggle   toggle supermaven-nvim
:SupermavenStatus   show status of supermaven-nvim
:SupermavenUseFree  switch to the free version
:SupermavenUsePro   switch to the pro version
:SupermavenLogout   log out of supermaven
:SupermavenShowLog  show logs for supermaven-nvim
:SupermavenClearLog clear logs for supermaven-nvim

https://github.com/supermaven-inc/supermaven-nvim/issues/29#issuecomment-2119386675
]]--

---@type LazySpec
return {
    'supermaven-inc/supermaven-nvim',
    keys = {
      { "<leader>TS", desc = 'Start Supermaven' },
    },
    opts = {
      color = {
        suggestion_color = '#ffffff',
        cterm = 244,
      },
      ignore_filtetypes = { 'git', 'node_modules', 'dist', 'build', 'target', 'vendor', '.env', '.env.local' },
      log_level = 'info', -- set to "off" to disable logging completely
      disable_inline_completion = false, -- disables inline completion for use with cmp
      disable_keymaps = false, -- disables built in keymaps for more manual control
      condition = function()
        return false
      end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
    }
  }
