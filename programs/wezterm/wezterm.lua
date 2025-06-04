-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux
wezterm.log_info("The config was reloaded for this window!")

local function mergeTables(t1, t2)
	for key, value in pairs(t2) do
		t1[key] = value
	end
end

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local config = {
	front_end = "WebGpu",
	max_fps = 120,

	font_size = 18.0,
	line_height = 1,
	cell_width = 1,

	default_workspace = "~",
	font = require("font").font,
	font_rules = require("font").font_rules,

	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	hide_tab_bar_if_only_one_tab = true,
	hide_mouse_cursor_when_typing = false,
	inactive_pane_hsb = {
		brightness = 0.9,
	},
	scrollback_lines = 5000,
	audible_bell = "Disabled",
	enable_scroll_bar = true,

	status_update_interval = 1000,
	xcursor_theme = "Adwaita", -- fix cursor bug on gnome + wayland
}

-- Actions shortcut
--local act = wezterm.action

-- This will hold the configuration.
--local config = wezterm.config_builder()

-- This is where you actually apply your config choices
--config.front_end = 'WebGpu'
--config.max_fps = 120

--config.color_scheme = 'tokyonight_storm'

-- For example, changing the color scheme:
--[[config.colors = {
  foreground = '#CBE0F0',
  -- background = '#011423',
  -- background = '#000000',
  background = '#1A1B27', -- tokyonight
  -- background = '#191724', -- rose-pine
  -- background = '#141414', -- gray
  cursor_bg = '#47FF9C',
  cursor_border = '#47FF9C',
  cursor_fg = '#011423',
  selection_bg = '#706b4e',
  selection_fg = '#f3d9c4',
  ansi = { '#214969', '#E52E2E', '#44FFB1', '#FFE073', '#0FC5ED', '#a277ff', '#24EAF7', '#24EAF7' },
  brights = { '#214969', '#E52E2E', '#44FFB1', '#FFE073', '#A277FF', '#a277ff', '#24EAF7', '#24EAF7' },
  tab_bar = {
    background = 'rgba(0,0,0,0)',
    active_tab = {
      -- The color of the background area for the tab
      bg_color = 'rgba(0,0,0,0)',
      fg_color = '#47FF9C',
    },
    inactive_tab = {
      -- The color of the background area for the tab
      bg_color = 'rgba(0,0,0,0)',
      fg_color = '#444444',
      italic = true,
    },
  },
}]]
--
--[[
config.background = {
  {
    source = {
      Color = 'rgb(26, 27, 39, 0.93)', -- #1A1B27
    },
    height = '100%',
    width = '100%',
    --opacity = 0.93,
  },
}

-- config.font = wezterm.font('MesloLGS Nerd Font Mono', { weight = 'Medium' })
-- config.freetype_load_flags = 'NO_HINTING'
config.font = wezterm.font('Fira Code', { weight = 'Regular' })
config.font_size = 16.0
config.line_height = 1.2
config.cell_width = 1

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = true

config.window_padding = {
  left = 8,
  right = 0,
  top = 8,
  bottom = 0,
}

config.window_frame = {
  --   border_left_width = '0.1cell',
  --   border_right_width = '0.1cell',
  --   border_bottom_height = '0.05cell',
  border_top_height = '0.05cell',
  --   border_left_color = '#212121',
  --   border_right_color = '#212121',
  --   border_bottom_color = '#181818',
  border_top_color = '#282828',
}

config.window_decorations = 'RESIZE'
--config.window_background_opacity = 0.93
config.macos_window_background_blur = 50
]]
--
-- WSL
--[[if is_windows then
	config.wsl_domains = {
		{
			name = "WSL:NixOS",
			distribution = "NixOS",
			default_cwd = "/home/mlflexer",
		},
	}
	config.default_domain = "WSL:NixOS"
end]]
--

local colors = require("colors")
mergeTables(config, colors)

config.leader = { key = "Space", mods = "CTRL|SHIFT", timeout_milliseconds = 1000 }
config.keys = require("keybinds")
config.mouse_bindings = require("mousebinds")
-- Actions
--[[wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace())
end)]]
--

-- https://github.com/MLFlexer/modal.wezterm
-- Vim-like modal keybindings for your terminal!
--[[local modal = wezterm.plugin.require("https://github.com/MLFlexer/modal.wezterm")
modal.enable_defaults("https://github.com/MLFlexer/modal.wezterm")
-- "ui_mode" can be replaced by any filename from the /defaults directory

local icons = {
  left_seperator = wezterm.nerdfonts.ple_left_half_circle_thick,
  key_hint_seperator = " | ",
  mod_seperator = "-",
}
local hint_colors = {
  key_hint_seperator = "Yellow",
  key = "Green",
  hint = "Red",
  bg = "Black",
  left_bg = "Gray",
}

modal.add_mode("Copy", require("copy_mode").key_table, require("copy_mode").get_hint_status_text(icons, hint_colors, { bg = "#ff9e64", fg = "Black" }))
modal.add_mode("Scroll", require("scroll_mode").key_table, require("scroll_mode").get_hint_status_text(icons, hint_colors, { bg = "#7aa2f7", fg = "Black" }))
modal.add_mode("Search", require("search_mode").key_table, require("search_mode").get_hint_status_text(icons, hint_colors, { bg = "#9d7cd8", fg = "Black" }))
modal.add_mode("UI", require("ui_mode").key_table, require("ui_mode").get_hint_status_text(icons, hint_colors, { bg = "#f7768e", fg = "Black" }))
modal.add_mode("Visual", require("visual_mode").key_table, require("visual_mode").get_hint_status_text(icons, hint_colors, { bg = "#9ece6a", fg = "Black" }))
]]
--

--[[config.keys = {
  -- Toggle full screen
  {
    key = 'n',
    mods = 'SHIFT|CTRL',
    action = act.ToggleFullScreen,
  },
  -- Create new tab
  {
    key = 't',
    mods = 'SHIFT|ALT',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
  -- Close current tab
  {
    key = 'q',
    mods = 'SHIFT|ALT',
    action = act.CloseCurrentTab { confirm = true },
  },
  -- Move through tabs
  {
    key = '[',
    mods = 'ALT',
    action = act.ActivateTabRelative(-1),
  },
  {
    key = ']',
    mods = 'ALT',
    action = act.ActivateTabRelative(1),
  },
  -- Switch tabs around
  {
    key = '{',
    mods = 'SHIFT|ALT',
    action = act.MoveTabRelative(-1),
  },
  {
    key = '}',
    mods = 'SHIFT|ALT',
    action = act.MoveTabRelative(1),
  },
  -- TODO: splits
  -- https://wezfurlong.org/wezterm/config/lua/keyassignment/SplitPane.html
  --
  -- VIM mode
}]]
--

local modal = wezterm.plugin.require("https://github.com/MLFlexer/modal.wezterm")
modal.apply_to_config(config)

wezterm.on("modal.enter", function(name, window, pane)
	modal.set_right_status(window, name)
	modal.set_window_title(pane, name)
end)

wezterm.on("modal.exit", function(name, window, pane)
	local title = basename(window:active_workspace())
	window:set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { Color = colors.colors.ansi[5] } },
		{ Text = title .. "  " },
	}))
	modal.reset_window_title(pane)
end)

local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
resurrect.periodic_save()
--[[resurrect.set_encryption({
	enable = true,
	private_key = wezterm.home_dir .. "/.age/resurrect.txt",
	public_key = "",
})]]
--

local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
workspace_switcher.apply_to_config(config)
workspace_switcher.workspace_formatter = function(label)
	return wezterm.format({
		{ Attribute = { Italic = true } },
		{ Foreground = { Color = colors.colors.ansi[3] } },
		{ Background = { Color = colors.colors.background } },
		{ Text = "󱂬 : " .. label },
	})
end

wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
	window:gui_window():set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { Color = colors.colors.ansi[5] } },
		{ Text = basename(path) .. "  " },
	}))
	local workspace_state = resurrect.workspace_state

	workspace_state.restore_workspace(resurrect.load_state(label, "workspace"), {
		window = window,
		relative = true,
		restore_text = true,
		on_pane_restore = resurrect.tab_state.default_on_pane_restore,
	})
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.chosen", function(window, path, label)
	window:gui_window():set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { Color = colors.colors.ansi[5] } },
		{ Text = basename(path) .. "  " },
	}))
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
	local workspace_state = resurrect.workspace_state
	resurrect.save_state(workspace_state.get_workspace_state())
end)

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config, {
	direction_keys = { "h", "j", "k", "l" },
	modifiers = {
		move = "CTRL",
		resize = "ALT",
	},
})

wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	local zoomed = ""
	if tab.active_pane.is_zoomed then
		zoomed = " "
	end

	local index = ""
	if #tabs > 1 then
		index = string.format("(%d/%d) ", tab.tab_index + 1, #tabs)
	end

	return zoomed .. index .. tab.active_pane.title
end)

wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

-- and finally, return the configuration to wezterm
return config
