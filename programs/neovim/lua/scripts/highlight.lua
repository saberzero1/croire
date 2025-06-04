local Gradient = {}
Gradient.__index = Gradient

-- Gradient colors for line numbers
function Gradient:highlight()
  if not vim.wo.number then
    return
  end
  vim.fn.sign_unplace('line_gradient')
  ---@type number
  local current_line = tonumber(vim.fn.getpos('.')[2])
  ---@type number
  local line_count = tonumber(vim.fn.getpos('$')[2])
  ---@type number
  local max_lines = 4
  ---@type number
  local max_above = math.min(current_line - 1, max_lines)
  ---@type number
  local max_below = math.min(line_count - current_line, max_lines)
  assert(max_above >= 0, 'max_above must be greater than or equal to 0')
  assert(max_below >= 0, 'max_below must be greater than or equal to 0')
  for index = 0, max_lines do
    vim.fn.sign_define('line_above_below_' .. tostring(index), { numhl = 'LineNr' .. tostring(index), texthl = 'LineNr' .. tostring(index) })
  end
  for index = current_line - max_above, current_line + max_below do
    vim.fn.sign_place(0, 'line_gradient', 'line_above_below_' .. tostring(vim.fn.abs(current_line - index)), vim.fn.bufname(''), { lnum = index, priority = 100 })
  end
end

--local status_bar = require('scripts.status-column')

return Gradient
