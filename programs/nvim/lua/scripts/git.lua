local builtin = require 'telescope.builtin'
local assert = require 'scripts.assertions'

Git = {}
Git.__index = Git

--- Concatenate a list of strings
---@param strings table List of strings to concatenate
---@return string Concatenated strings
local concat = function(strings)
  assert:is_table(strings)
  return table.concat(strings, ' ')
end

-- Override the print function to use the notify function from nvim-notify
local notify = require 'notify'
vim.notify = notify
print = function(...)
  local print_safe_args = {}
  local _ = { ... }
  for i = 1, #_ do
    table.insert(print_safe_args, tostring(_[i]))
  end
  notify(table.concat(print_safe_args, ' '), 'info')
end
notify.setup()

-- Execute a command asynchronously
-- https://github.com/nvim-lua/plenary.nvim/blob/986ad71ae930c7d96e812734540511b4ca838aa2/lua/plenary/job.lua#L6-L20
-- https://www.reddit.com/r/neovim/comments/wb600w/comment/ii4uakq/
local job = require 'plenary.job'
local exec_async = function(command, args, on_start, on_exit)
  job
    :new({
      command = command,
      args = args,
      on_start = function()
        print(on_start)
      end,
      on_exit = function()
        print(on_exit)
      end,
    })
    :start()
end

-- execute a command synchronously
local exec_sync = function(command, args, on_start, on_exit)
  print(on_start)
  job:new({ command = command, args = args }):sync()
  print(on_exit)
end

--[[
local job = require 'plenary.job'
-- async
local data = {}
job:new({
	command = 'ls',
	args = { '-a' },
	on_stdout = function(_, line)
		table.insert(data, line)
	end,
	on_exit = function()
		print('done')
	end,
}):start()
-- sync
local ls = job:new({ command = "ls", args = { "-a" } }):sync()
for i, _ in ipairs(ls) do
	assert(ls[i] == data[i])
end
]]
--

--- Call Git command
---@param command string Git command to call
---@param options? string Options to pass to the Git command
---@param input? boolean Ask for input
---@param question? string Question to ask the user
---@param async? boolean Run the command asynchronously
function Git:call(command, options, input, question, async)
  input = input or false
  assert:is_string(command, false)
  assert:not_empty(command)
  assert:is_string(options)
  assert:is_boolean(input)
  assert:is_string(question, not input)
  assert:is_boolean(async)
  options = options or ''
  async = async or false
  local git_command = concat { 'git', command, options }
  if input then
    if question ~= nil then
      input = vim.fn.input(concat { question, ': ' })
    else
      input = vim.fn.input(concat { 'Enter input for git', git_command:sub(5), ': ' })
    end
    if async then
      exec_async('git', { command, options, input }, concat { 'Started running', git_command }, concat { 'Finished running git', git_command:sub(5) })
    else
      exec_sync('git', { command, options, input }, concat { 'Started running', git_command }, concat { 'Finished running git', git_command:sub(5) })
    end
  else
    if async then
      exec_async('git', { command, options }, concat { 'Started running', git_command }, concat { 'Finished running git', git_command:sub(5) })
    else
      exec_sync('git', { command, options }, concat { 'Started running', git_command }, concat { 'Finished running git', git_command:sub(5) })
    end
  end
end

--- Format options for Git commands
---@param options string Options to format
---@param default? string Default options
---@return string Formatted options
local function opt(options, default)
  assert:is_string(options)
  assert:is_string(default)
  default = default or ''
  if default:sub(3) ~= '--' then
    default = '--' .. default
  end
  if options == nil or options == '' then
    return default
  else
    return '--' .. options
  end
end

--- Add operations
---@param options? string Options to pass to the Git command
function Git:add(options)
  assert:is_string(options)
  git.call('add', options or '.', nil, nil, true)
end

--- Branch operations
---@param options? string Options to pass to the Git command
function Git:branch(options)
  assert:is_string(options)
  if options == nil or options == '' then
    assert:not_empty(builtin)
    builtin.git_branches()
  else
    git.call('branch', options, nil, nil, true)
  end
end

--- Checkout operations
---@param options? string Options to pass to the Git command
function Git:checkout(options)
  assert:is_string(options)
  if options == nil or options == '' then
    assert:not_empty(builtin)
    builtin.git_branches()
  else
    git.call('checkout', options, nil, nil, true)
  end
end

--- Set the value of a config option
---@param option string Config option to set
---@param value? string Value to set the config option to
---@param scope? string Scope of the config option (global, local)
function Git:config_set(option, value, scope)
  assert:is_string(option)
  scope = opt(scope or '', 'global')
  if value == nil or value == '' then
    value = vim.fn.input(concat { 'Set', scope:sub(3), 'value for', option, ': ' })
  end
  if value == nil or value == '' then
    print(concat { 'Value', '"' .. tostring(value) .. '"', ' is not valid for', scope:sub(3), option })
    return
  end
  exec_async(
    'git',
    { 'config', scope, option, value },
    concat { 'Running git', scope, option, value },
    concat { 'Set', scope:sub(3), option, 'to', '"' .. value .. '"' }
  )
end

--- Get the current value of a config option
---@param value? string Config option to get
---@param scope? string Scope of the config option (global, local)
function Git:config_get(value, scope)
  assert:is_string(value)
  assert:is_string(scope)
  scope = opt(scope or '', 'global')
  if value == nil or value == '' then
    vim.api.nvim_command(concat { 'Git config', scope, '--list' })
  else
    local current = vim.api.nvim_exec2(concat { 'Git config', scope, value }, { output = true })
    if current == nil or current == '' then
      print(concat { 'Option', value, 'not set in scope', scope:sub(3) })
    else
      print(concat { 'Current', scope:sub(3), value, 'is', '"' .. current .. '"' })
    end
  end
end

--- Fetch operations
---@param options? string Options to pass to the Git command
function Git:fetch(options)
  assert:is_string(options)
  git.call('fetch', opt(options or ''), nil, nil, true)
end

--- Grep (ls-files) operations
function Git:grep()
  assert:not_empty(builtin)
  builtin.git_files()
end

--- Init operations
---@param options? string Options to pass to the Git Init command
function Git:init(options)
  assert:is_string(options)
  git.call('init', opt(options or ''), nil, nil, true)
end

--- Pull operations
---@param options? string Options to pass to the Git Pull command
function Git:pull(options)
  assert:is_string(options)
  git.fetch()
  git.call('pull', opt(options or ''), nil, nil, true)
end

--- Push operations
---@param options? string Options to pass to the Git Push command
function Git:push(options)
  assert:is_string(options)
  git.fetch()
  git.call('push', opt(options or ''), nil, nil, true)
end

--- Status operations
function Git:status()
  assert:not_empty(builtin)
  builtin.git_status()
end

--- Stash operations
function Git:stash()
  assert:not_empty(builtin)
  builtin.git_stash()
end

return Git
