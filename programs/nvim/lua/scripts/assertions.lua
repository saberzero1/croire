Assertions = {}
Assertions.__index = Assertions

--- Assert type of variable
---@param variable any Variable to check the type of
---@param expected string Expected type of the variable
---@param allow_nil? boolean Allow the variable to be nil
function Assertions:is_type(variable, expected, allow_nil)
  allow_nil = allow_nil or true
  if allow_nil then
    assert(variable == nil or type(variable) == expected, concat({ 'Variable must be of type', expected }))
  else
    assert(type(variable) == expected, concat({ 'Variable must be of type', expected }))
  end
end

--- Assert that a variable is a table
---@param variable any Variable to check
---@param allow_nil? boolean Allow the variable to be nil
function Assertions:is_table(variable, allow_nil)
  allow_nil = allow_nil or true
  if allow_nil then
    assert(variable == nil or type(variable) == 'table', 'Variable must be a table')
  else
    assert(type(variable) == 'table', 'Variable must be a table')
  end
end

--- Assert that a variable is a string
---@param variable any Variable to check
---@param allow_nil? boolean Allow the variable to be nil
function Assertions:is_string(variable, allow_nil)
  allow_nil = allow_nil or true
  if allow_nil then
      assert(variable == nil or type(variable) == 'string', 'Variable must be a string')
  else
      assert(type(variable) == 'string', 'Variable must be a string')
  end
end

--- Assert that a variable is a number
---@param variable any Variable to check
---@param allow_nil? boolean Allow the variable to be nil
function Assertions:is_number(variable, allow_nil)
  allow_nil = allow_nil or true
  if allow_nil then
    assert(variable == nil or type(variable) == 'number', 'Variable must be a number')
  else
    assert(type(variable) == 'number', 'Variable must be a number')
  end
end

--- Assert that a variable is a boolean
---@param variable any Variable to check
---@param allow_nil? boolean Allow the variable to be nil
function Assertions:is_boolean(variable, allow_nil)
  allow_nil = allow_nil or true
  if allow_nil then
    assert(variable == nil or type(variable) == 'boolean', 'Variable must be a boolean')
  else
    assert(type(variable) == 'boolean', 'Variable must be a boolean')
  end
end

--- Assert that a variable is a function
---@param variable any Variable to check
---@param allow_nil? boolean Allow the variable to be nil
function Assertions:is_function(variable, allow_nil)
  allow_nil = allow_nil or true
  if allow_nil then
    assert(variable == nil or type(variable) == 'function', 'Variable must be a function')
  else
    assert(type(variable) == 'function', 'Variable must be a function')
  end
end

--- Assert that a variable is a thread
---@param variable any Variable to check
---@param allow_nil? boolean Allow the variable to be nil
function Assertions:is_thread(variable, allow_nil)
  allow_nil = allow_nil or true
  if allow_nil then
    assert(variable == nil or type(variable) == 'thread', 'Variable must be a thread')
  else
    assert(type(variable) == 'thread', 'Variable must be a thread')
  end
end

--- Assert that a variable is a userdata
---@param variable any Variable to check
---@param allow_nil? boolean Allow the variable to be nil
function Assertions:is_userdata(variable, allow_nil)
  allow_nil = allow_nil or true
  if allow_nil then
    assert(variable == nil or type(variable) == 'userdata', 'Variable must be a userdata')
  else
    assert(type(variable) == 'userdata', 'Variable must be a userdata')
  end
end

--- Assert that a variable is a nil
---@param variable any Variable to check
function Assertions:is_nil(variable)
  assert(variable == nil, 'Variable must be nil')
end

--- Assert that a variable is empty
---@param variable any Variable to check
function Assertions:empty(variable)
  assert(variable == nil or variable == '', 'Variable must be nil or empty')
end

--- Assert that a variable is not empty
---@param variable any Variable to check
function Assertions:not_empty(variable)
  assert(variable ~= nil, 'Variable must not be nil')
  if type(variable) == 'string' then
    assert(variable ~= '', 'Variable must not be empty')
  end
end

--- Assert that a variable is equal to another variable
---@param variable any Variable to check
---@param expected any Expected value
function Assertions:equal(variable, expected)
  assert(variable == expected, 'Variable must be equal to expected value')
end

--- Assert that a variable is not equal to another variable
---@param variable any Variable to check
---@param expected any Expected value
function Assertions:not_equal(variable, expected)
  assert(variable ~= expected, 'Variable must not be equal to expected value')
end

--- Assert that a variable is greater than another variable
---@param variable any Variable to check
---@param expected any Expected value
function Assertions:greater_than(variable, expected, or_equal)
  assert(variable > expected, 'Variable must be greater than expected value')
end

--- Assert that a variable is less than another variable
---@param variable any Variable to check
---@param expected any Expected value
function Assertions:less_than(variable, expected, or_equal)
  assert(variable < expected, 'Variable must be less than expected value')
end

--- Assert that a variable is greater than or equal to another variable
---@param variable any Variable to check
---@param expected any Expected value
function Assertions:greater_than_or_equal(variable, expected)
  assert(variable >= expected, 'Variable must be greater than or equal to expected value')
end

--- Assert that a variable is less than or equal to another variable
---@param variable any Variable to check
---@param expected any Expected value
function Assertions:less_than_or_equal(variable, expected)
  assert(variable <= expected, 'Variable must be less than or equal to expected value')
end

--- Assert that a variable is true
---@param variable any Variable to checkout
function Assertions:is_true(variable)
  assert(variable == true, 'Variable must be true')
end

--- Assert that a variable is false
---@param variable any Variable to checkout
function Assertions:is_false(variable)
  assert(variable == false, 'Variable must be false')
end

--- Assert that a variable is a key in a table
---@param variable any Variable to check
---@param table table Table to check
function Assertions:is_key(variable, table)
  assert(table[variable] ~= nil, 'Variable must be a key in the table')
end

--- Assert that a variable is not a key in a table
---@param variable any Variable to check
---@param table table Table to check
function Assertions:not_key(variable, table)
  assert(table[variable] == nil, 'Variable must not be a key in the table')
end

--- Assert that a variable is a value in a table
---@param variable any Variable to check
---@param table table Table to check
function Assertions:is_value(variable, table)
  for _, value in pairs(table) do
    if value == variable then
      return
    end
  end
  assert(false, 'Variable must be a value in the table')
end

--- Assert that a variable is not a value in a table
---@param variable any Variable to check
---@param table table Table to check
function Assertions:not_value(variable, table)
  for _, value in pairs(table) do
    if value == variable then
      assert(false, 'Variable must not be a value in the table')
    end
  end
end

--- Assert that at least one assertion is true
---@param assertions table Table of assertions
function Assertions:any(assertions)
  for _, assertion in pairs(assertions) do
    if assertion then
      return
    end
  end
  assert(false, 'At least one assertion must be true')
end

--- Assert that all assertions are true
---@param assertions table Table of assertions
function Assertions:all(assertions)
  for _, assertion in pairs(assertions) do
    if not assertion then
      assert(false, 'All assertions must be true')
    end
  end
end

--- Assert that a function throws an error
---@param func function Function to call
function Assertions:throws_error(func)
  local status, err = pcall(func)
  assert(not status, 'Function must throw an error')
end

--- Assert that a function does not throw an error
---@param func function Function to call
function Assertions:not_throws_error(func)
  local status, err = pcall(func)
  assert(status, 'Function must not throw an error')
end

--- Assert that a function returns a value
---@param func function Function to call
---@param expected any Expected value
function Assertions:returns(func, expected)
  local value = func()
  assert(value == expected, 'Function must return expected value')
end

--- Assert that a function does not return a value
---@param func function Function to call
function Assertions:not_returns(func)
  local value = func()
  assert(value == nil, 'Function must not return a value')
end

return Assertions