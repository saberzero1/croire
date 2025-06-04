local assert = require 'scripts.assertions'

Util = {}
Util.__index = Util

--- Concat table of strings
---@param strings table Table of strings
---@return string Concatenated strings
function Util:concat(strings)
  assert:is_table(strings)
  return table.concat(strings, ' ')
end

return Util
