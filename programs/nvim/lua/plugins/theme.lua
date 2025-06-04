local alpha = function()
  return string.format('%x', math.floor(255 * (vim.g.neovide_transparency_point or 0.8)))
end

require 'scripts.highlight'

---@type LazySpec
return { -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require 'tokyonight'.setup({
      transparent = true,
      style = 'storm',
      light_style = 'day',
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
        statusline = 'transparent',
      },
      --- You can override specific color groups to use other groups or a hex color
      --- function will be called with a ColorScheme table
      ---@param colors ColorScheme
      on_colors = function(colors)
        colors.bg_statusline = colors.bg_statusline
        colors.LineNr4 = '#3B4261'
        colors.LineNr3 = '#4d71a0'
        colors.LineNr2 = '#6fc1cf'
        colors.LineNr1 = '#eeffee'
        colors.LineNr0 = '#FF9D65'
            --.none -- To check if its working try something like "#ff00ff" instead of colors.none
      end,
      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      ---@param highlights tokyonight.Highlights
      ---@param colors ColorScheme
      on_highlights = function(highlights, colors)
        highlights.TreesitterContext = { bg = 'NONE' }
        highlights.TreesitterContextLineNumber = { bg = 'NONE' }
        highlights.LineNr4 = { fg = colors.LineNr4 }
        highlights.LineNr3 = { fg = colors.LineNr3 }
        highlights.LineNr2 = { fg = colors.LineNr2 }
        highlights.LineNr1 = { fg = colors.LineNr1 }
        highlights.LineNr0 = { fg = colors.LineNr0, bold = true }
      end,
    })
  end
}
