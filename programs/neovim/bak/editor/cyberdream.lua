local alpha = function()
  return string.format("%x", math.floor(255 * (vim.g.neovide_transparency_point or 0.8)))
end

return {
  --[["scottmckendry/cyberdream.nvim",
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      -- Enable transparent background
      transparent = true,

      -- Enable italics comments
      italic_comments = true,

      -- Replace all fillchars with ' ' for the ultimate clean look
      hide_fillchars = false,

      -- Modern borderless telescope theme
      borderless_telescope = false,

      -- Set terminal colors used in `:terminal`
      terminal_colors = true,

      theme = {
        variant = "auto", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`
        highlights = {
          -- Highlight groups to override, adding new groups is also possible
          -- See `:h highlight-groups` for a list of highlight groups or run `:hi` to see all groups and their current values

          -- Example:
          -- Comment = { fg = "#696969", bg = "NONE", italic = true },
          LineNr4 = { fg = "#3B4261" },
          LineNr3 = { fg = "#4d71a0" },
          LineNr2 = { fg = "#6fc1cf" },
          LineNr1 = { fg = "#eeffee" },
          LineNr0 = { fg = "#FFFFFF", bg = "NONE", bold = true }

          -- Complete list can be found in `lua/cyberdream/theme.lua`
        },

        -- Override a highlight group entirely using the color palette
        -- overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
        --   -- Example:
        --   return {
        --     Comment = { fg = colors.green, bg = "NONE", italic = true },
        --     ["@property"] = { fg = colors.magenta, bold = true },
        --   }
        -- end,
        
        -- Override a color entirely
        colors = {
          -- For a list of colors see `lua/cyberdream/colours.lua`
          -- Example:
          -- bg = "#000000",
          -- green = "#00ff00",
          -- magenta = "#ff00ff",
          bg = "#24283b",
          bgAlt = "#1f2335",
          bgHighlight = "#292e42",
          fg = "#c0caf5",
          blue = "#7aa2f7",
          green = "#9ece6a",
          cyan = "#7dcfff",
          red = "#f7768e",
          pink = "#1abc9c", --teal
          yellow = "#e0af68",
          magenta = "#bb9af7",
          orange = "#ff9e64",
          purple = "#9d7cd8",
        },
      },

      -- Disable or enable colorscheme extensions
      extensions = {
        telescope = true,
        notify = true,
        mini = true,
      },
    })
    if vim.g.neovide then
      -- Set transparency and background color (title bar color)
      vim.g.neovide_background_color_base = "#2a2839"
      vim.g.neovide_background_color = vim.g.neovide_background_color_base .. alpha()
      vim.cmd.colorscheme('cyberdream')
    else
      vim.cmd.colorscheme('cyberdream') -- setting
    end
  end]]--
}