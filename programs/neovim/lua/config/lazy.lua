-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.env.LAZY or vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- validate that lazy is available
if not pcall(require, 'lazy') then
  -- stylua: ignore
  vim.api.nvim_echo({ { ('Unable to load lazy from: %s\n'):format(lazypath), 'ErrorMsg' }, { 'Press any key to exit...', 'MoreMsg' } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

local settings = require 'config.extra.lazy'

require 'lazy'.setup({
  spec = settings.spec,
  -- Configure any other `lazy.nvim` configuration options here
  ui = settings.ui,
  performance = settings.performance,
  checker = settings.checker,
  default = settings.default,
} --[[@as LazyConfig]])

require 'config.after'
