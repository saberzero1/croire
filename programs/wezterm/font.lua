local font = require('wezterm').font
local font_with_fallback = require('wezterm').font_with_fallback
local harfbuzz_features = { 'calt', 'liga', 'dlig', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08' }

local function os_specific_font(families)
  if require('wezterm').target_triple:find 'darwin' ~= nil and families[2] ~= nil then
    return font_with_fallback { families[2] }
  end
  return font_with_fallback { families[1] }
end

return {
  -- default font
  font = os_specific_font {
    {
      family = 'Monaspace Neon',
      -- family = "Monaspace Argon",
      -- family = "Monaspace Xenon",
      -- family = "Monaspace Radon",
      -- family = "Monaspace Krypton",
      weight = 'Medium',
      harfbuzz_features = harfbuzz_features,
    },
    {
      family = 'MonaspiceNe Nerd Font',
      -- family = "MonaspiceAr Nerd Font",
      -- family = "MonaspiceXe Nerd Font",
      -- family = "MonaspiceRa Nerd Font",
      -- family = "MonaspiceKr Nerd Font",
      weight = 'Medium',
      harfbuzz_features = harfbuzz_features,
    },
  },

  font_rules = {
    { -- Normal
      intensity = 'Normal',
      italic = false,
      font = os_specific_font {
        {
          family = 'Monaspace Neon',
          weight = 'Medium',
          harfbuzz_features = harfbuzz_features,
        },
        {
          family = 'MonaspiceNe Nerd Font',
          weight = 'Medium',
          harfbuzz_features = harfbuzz_features,
        },
      },
    },
    { -- Bold
      intensity = 'Bold',
      italic = false,
      font = os_specific_font {
        {
          family = 'Monaspace Argon',
          weight = 'ExtraBold',
          harfbuzz_features = harfbuzz_features,
        },
        {
          family = 'MonaspiceAr Nerd Font',
          weight = 'ExtraBold',
          harfbuzz_features = harfbuzz_features,
        },
      },
    },
    { -- Half
      intensity = 'Half',
      italic = false,
      font = os_specific_font {
        {
          family = 'Monaspace Krypton',
          weight = 'Book',
          harfbuzz_features = harfbuzz_features,
        },
        {
          family = 'MonaspicaKr Nerd Font',
          weight = 'Book',
          harfbuzz_features = harfbuzz_features,
        },
      },
    },
    { -- Normal italic
      intensity = 'Normal',
      italic = true,
      font = os_specific_font {
        {
          family = 'Monaspace Argon',
          weight = 'Regular',
          style = 'Italic',
          harfbuzz_features = harfbuzz_features,
        },
        {
          family = 'MonaspiceAr Nerd Font',
          weight = 'Regular',
          style = 'Italic',
          harfbuzz_features = harfbuzz_features,
        },
      },
    },
    { -- Bold italic
      intensity = 'Bold',
      italic = true,
      font = os_specific_font {
        {
          family = 'Monaspace Argon',
          weight = 'DemiBold',
          style = 'Italic',
          harfbuzz_features = harfbuzz_features,
        },
        {
          family = 'MonaspiceAr Nerd Font',
          weight = 'DemiBold',
          style = 'Italic',
          harfbuzz_features = harfbuzz_features,
        },
      },
    },
    { -- Half italic
      intensity = 'Half',
      italic = true,
      font = os_specific_font {
        {
          family = 'Monaspace Argon',
          weight = 'Thin',
          style = 'Italic',
          harfbuzz_features = harfbuzz_features,
        },
        {
          family = 'MonaspiceAr Nerd Font',
          weight = 'Thin',
          style = 'Italic',
          harfbuzz_features = harfbuzz_features,
        },
      },
    },
  },
}
