local assert = require 'scripts.assertions'

Keymapper = {}
Keymapper.__index = Keymapper

--- Flatten keymap
---@param prefix prefix so far
---@param keymap nvim keyman to flatten
---@param result? resulting keymap
---@return table Flattened keymap
function Keymapper:flatten(prefix, keymap, result)
  result = result or {}
  local wk = require 'which-key'

  for key, value in pairs(keymap) do
    local new_prefix = prefix .. key
    if key == 'opts' then
      opts = value[1] or {}
      table.insert(result, { 'opts', prefix, opts })
    elseif type(value[1]) == 'function' then
      -- Add the flattened keymap entry to the result
      opts = value[2] or {}
      table.insert(result, { new_prefix, value[1], opts })
    else
      -- Recursively process nested keymaps
      Keymapper:flatten(new_prefix, value, result)
    end
  end

  return result
end

--- Build lazy.nvim keymap from flattened keymap
---@param flattened_keymap Flattened keymap to build
---@return table Built keymap
function Keymapper:build(flattened_keymap)
  local result = {}
  for _, entry in ipairs(flattened_keymap) do
    if entry[1] == 'opts' then
      opts = entry[3]
      table.insert(result, { entry[2], group = opts.group or nil, mode = opts.mode or 'n' })
    else
      opts = entry[3] or {}
      table.insert(result, { entry[1], entry[2], desc = opts.desc or '', silent = opts.silent or false, noremap = opts.noremap or false })
    end
  end
  return result
end

--- Parse keymaps
---@param keymap keymap to parse
---@return table Parsed keymap
function Keymapper:parse(keymap)
  --assert:not_empty(keymap)
  local wk = require 'which-key'
  local flattened = Keymapper:flatten('', keymap)
  assert:is_table(flattened)
  result = Keymapper:build(flattened)
  wk.add(result)
  return {}
end

return Keymapper
