local statuscolumn = {}

local colors = require 'tokyonight.colors'.setup() -- pass in any of the config options as explained above

local gitsigns = require 'gitsigns'
-- Get hl values from gitsigns
vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = colors.git.add })
vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = colors.git.change })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = colors.git.delete })
vim.api.nvim_set_hl(0, 'GitSignsChangeDelete', { fg = colors.git.change })
vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { fg = colors.git.delete })

statuscolumn.status_bar = function ()
  local text = ""

  text = table.concat({
    --statuscolumn.gitsigns(),
    statuscolumn.folds(),
    statuscolumn.number({ mode = "hybrid" }),
    statuscolumn.border(),
  })

  return text
end

statuscolumn.gitsigns = function()
  return '%=%s'
end

statuscolumn.border = function ()
  -- NOTE: lua tables start at 1 but relnum starts at 0, so we add 1 to it to get the highlight group
  if vim.v.relnum < 9 then
    return "%=%#Gradient_" .. (vim.v.lnum + 1) .. "#┃"
  else
    return "%=%#Gradient_10#┃"
  end
end

statuscolumn.setHl = function ()
  local hl_colors = { "#3B4261", "#4d71a0", "#6fc1cf", "#eeffee", "#FF9D65", "#eeffee", "#6fc1cf", "#4d71a0", "#3B4261" }

  for index, hl_color in ipairs(hl_colors) do
    vim.api.nvim_set_hl(0, "Gradient_" .. tostring(index), { fg = hl_color })
  end
end

statuscolumn.number = function (user_config)
  -- As a failsafe we will return an empty string if something breaks
  local text = ""

  -- This is how plugins set the default options for a configuration table(an empty table is used if the user config is nil)
  -- This merges the default values and the user provided values so that you don't need to have all the keys in your config table
  local config = vim.tbl_extend("keep", user_config or {}, {
    colors = { "LineNr4", "LineNr3", "LineNr2", "LineNr1", "LineNr0", "LineNr1", "LineNr2", "LineNr3", "LineNr4" },
    mode = "normal"
  })

  -- islist() was previously called tbl_islist() so use that if you are using an older version
  if config.colors ~= nil and vim.islist(config.colors) == true then
    for rel_numb, hl in ipairs(config.colors) do
      -- Only 1 highlight group
      if (vim.v.relnum + 1) == rel_num then
        text = "%=%#" .. colors .. "#"
        break
      end
    end
    
    -- If the string is still empty then use the last color
    if text == "" then
      text = "%=%#" .. config.colors[#config.colors] .. "#"
    end
  end

  if config.mode == "normal" then
    text = text .. vim.v.lnum
  elseif config.mode == "relative" then
    text = text .. vim.v.relnum
  elseif config.mode == "hybrid" then
    return vim.v.relnum == 0 and text .. vim.v.lnum or text .. vim.v.relnum
  end

  return text
end

statuscolumn.folds = function ()
  local foldlevel = vim.fn.foldlevel(vim.v.lnum)
  local foldlevel_before = vim.fn.foldlevel((vim.v.lnum - 1) >= 1 and vim.v.lnum - 1 or 1)
  local foldlevel_after = vim.fn.foldlevel((vim.v.lnum + 1) <= vim.fn.line("$") and (vim.v.lnum + 1) or vim.fn.line("$"))


  local foldclosed = vim.fn.foldclosed(vim.v.lnum)

  -- Line has nothing to do with folds so we will skip it
  if foldlevel == 0 then
    return " "
  end

  -- Line is a closed fold(I know second condition feels unnecessary but I will still add it)
  if foldclosed ~= -1 and foldclosed == vim.v.lnum then
    return "▶"
  end

  -- I didn't use ~= because it couldn't make a nested fold have a lower level than it's parent fold and it's not something I would use
  if foldlevel > foldlevel_before then
    return "▽"
  end

  -- The line is the last line in the fold
  if foldlevel > foldlevel_after then
    return "╰"
  end

  -- Line is in the middle of an open fold
  return "╎"
end

-- With this line we will be able to use myStatuscolumn by requiring this file and calling the function
return statuscolumn