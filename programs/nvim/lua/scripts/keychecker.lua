local keychecker = {
  file = {
    type = {},
  },
  git = {
    in_repo = {},
  },
  line = {},
  mode = {},
}

local current_file_in_git = false

vim.api.nvim_create_augroup('keychecker', {clear = false})

vim.api.nvim_create_autocmd('BufReadPost', {
  group = 'keychecker',
  pattern = '*',
  callback = function()
    local result = pcall(vim.system({'git', 'rev-parse', '--is-inside-work-tree'}))
    current_file_in_git = (result == 'false' or result == 'true')
  end,
})

--- Check if the current file type is in the valid types
--- @param valid_filetypes table The valid filetypes
--- @return boolean If the current file type is in the valid types
keychecker.file.type = function(valid_filetypes)
  if #valid_filetypes == 0 then
    return false
  end

  local current_filetype = vim.api.nvim_get_current_buf().filetype

  for i = 1, #valid_filetypes do
    if valid_filetypes[i] == current_filetype then
      return true
    end
  end

  return false
end

--- Check if the current file is in a git repository
--- @return boolean If the current file is in a git repository
keychecker.git.in_repo = function()
  return current_file_in_git
end

--- Check if the current line is in the valid range
--- @param valid_range table The valid range of lines
--- @return boolean If the current line is in the valid range
keychecker.line = function(valid_range)
  if #valid_range == 0 then
    return false
  end
  
  local current_line = tonumber(vim.api.nvim_win_get_cursor(0)[1])

  if #valid_range == 1 then
    return current_line == valid_range[1]
  end

  if #valid_range == 2 then
    return current_line >= valid_range[1] and current_line <= valid_range[2]
  end

  return false
end

--- Check if the current mode is in the expected modes
--- @param expected_modes table The expected modes
--- @return boolean If the current mode is in the expected modes
keychecker.mode = function(expected_modes)
  if #expected_modes == 0 then
    return false
  end

  local current_mode = vim.api.nvim_get_mode()

  for i = 1, #expected_modes do
    if expected_modes[i] == current_mode then
      return true
    end
  end

  return false
end

return keychecker