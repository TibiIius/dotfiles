-- Pull in the wezterm API
local wezterm = require("wezterm")
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")

local config = wezterm.config_builder()

function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Gruvbox Material Dark (Medium)"
	else
		return "Gruvbox Material Light (Hard)"
	end
end

bar.apply_to_config(config)

config = {
	color_scheme = scheme_for_appearance(get_appearance()),
	set_environment_variables = {
		PATH = "/opt/homebrew/bin",
	},
	leader = {
		key = "phys:Space",
		mods = "SHIFT",
		timeout_milliseconds = 1000,
	},
	keys = { -- ... add these new entries to your config.keys table
		{
			-- I'm used to tmux bindings, so am using the quotes (") key to
			-- split horizontally, and the percent (%) key to split vertically.
			key = '"',
			-- Note that instead of a key modifier mapped to a key on your keyboard
			-- like CTRL or ALT, we can use the LEADER modifier instead.
			-- This means that this binding will be invoked when you press the leader
			-- (CTRL + A), quickly followed by quotes (").
			mods = "LEADER|SHIFT",
			action = wezterm.action.SplitHorizontal({
				domain = "CurrentPaneDomain",
			}),
		},
		{
			key = "%",
			mods = "LEADER|SHIFT",
			action = wezterm.action.SplitVertical({
				domain = "CurrentPaneDomain",
			}),
		},
	},
	font = wezterm.font("Liga SFMono Nerd Font", {
		bold = false,
		italic = false,
	}),
	font_size = 13.0,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = false,
	tab_bar_at_bottom = true,
	scroll_to_bottom_on_input = true,
	-- default_prog = { "nu" },
	window_background_opacity = 1.00,
	macos_window_background_blur = 100,
	win32_system_backdrop = "Tabbed",
	front_end = "OpenGL",
	window_frame = {
		font = wezterm.font({
			family = "Liga SFMono Nerd Font",
			weight = "Regular",
		}),
		font_size = 13.0,
		active_titlebar_bg = "none",
		inactive_titlebar_bg = "none",
	},
	window_padding = {
		left = 6,
		right = 6,
		top = 6,
		bottom = 6,
	},
	-- term = "wezterm",
	window_decorations = "MACOS_FORCE_ENABLE_SHADOW | TITLE | RESIZE",
	native_macos_fullscreen_mode = true,
	colors = {
		tab_bar = {
			inactive_tab_edge = "#575757",
			background = "none",
			-- Inactive tabs are the tabs that do not have focus
			inactive_tab = {
				bg_color = "none",
				fg_color = "#808080",
			},
			inactive_tab_hover = {
				bg_color = "rgba(51, 51, 51, 1)",
				fg_color = "#808080",
				italic = true,
			},
			active_tab = {
				-- bg_color = '#333333',
				bg_color = "none",
				fg_color = "#c0c0c0",
				intensity = "Bold",
				italic = true,
			},
			new_tab = {
				bg_color = "none",
				fg_color = "#808080",
			},
			new_tab_hover = {
				bg_color = "rgba(51, 51, 51, 1)",
				fg_color = "#808080",
				italic = true,
			},
		},
	},
	color_schemes = {
		["Gruvbox Material Dark (Hard)"] = {
			foreground = "#D4BE98",
			background = "#1D2021",
			cursor_bg = "#D4BE98",
			cursor_border = "#D4BE98",
			cursor_fg = "#1D2021",
			selection_bg = "#D4BE98",
			selection_fg = "#3C3836",

			ansi = { "#1d2021", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
			brights = { "#eddeb5", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
		},
		["Gruvbox Material Dark (Medium)"] = {
			foreground = "#D4BE98",
			background = "#282828",
			cursor_bg = "#D4BE98",
			cursor_border = "#D4BE98",
			cursor_fg = "#282828",
			selection_bg = "#D4BE98",
			selection_fg = "#45403d",

			ansi = { "#282828", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
			brights = { "#eddeb5", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
		},
		["Gruvbox Material Dark (Soft)"] = {},
		["Gruvbox Material Light (Hard)"] = {
			foreground = "#654735",
			background = "#F9F5D7",
			cursor_bg = "#654735",
			cursor_border = "#654735",
			cursor_fg = "#F9F5D7",
			selection_bg = "#F3EAC7",
			selection_fg = "#4F3829",

			ansi = { "#1d2021", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
			brights = { "#eddeb5", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
		},
		["Gruvbox Material Light (Medium)"] = {},
		["Gruvbox Material Light (Soft)"] = {},
	},
}

-- and finally, return the configuration to wezterm
return config
