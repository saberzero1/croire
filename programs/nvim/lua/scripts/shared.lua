local assert = require 'scripts.assertions'

Shared = {}
Shared.__index = Shared

--- Returns configured git signs
function Shared:git_signs()
  local sign = {
    add = '+',
    change = '~',
    delete = '_',
    topdelete = '‾',
    changedelete = '~',
    rename = 'r',
    untracked = '?',
  }

  if vim.g.have_nerd_font then
    sign = {
      add = '',
      change = '',
      delete = '',
      topdelete = '',
      changedelete = '',
      rename = '',
      untracked = '',
    }
  end

  return sign
end

--- Returns file and directory icons
function Shared:explorer_icons()
  local icons = {
    directory = 'D',
    directory_open_fill = 'D',
    directory_fill = 'O',
    directory_symlink = 'L',
    directory_submodule = 'W',
    file = 'f',
    file_text = 't',
    file_code = 'c',
    file_image = 'i',
    file_video = 'v',
    file_audio = 'a',
    file_cloud = 'c',
    file_zip = 'z',
  }

  if vim.g.have_nerd_font then
    icons = {
      directory = '',
      directory_open_fill = '',
      directory_fill = '',
      directory_symlink = '',
      directory_submodule = '',
      file = '',
      file_text = '',
      file_code = '',
      file_image = '',
      file_video = '',
      file_audio = '',
      file_cloud = '󰈗',
      file_zip = '',
    }
  end

  return icons
end

return Shared
