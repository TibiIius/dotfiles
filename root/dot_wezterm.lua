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
		return "Gruvbox dark, pale (base16)"
	else
		return "Gruvbox light, hard (base16)"
	end
end

config = {
	color_scheme = scheme_for_appearance(get_appearance()),
	set_environment_variables = {
		PATH = "/opt/homebrew/bin",
	},
	leader = {
		key = "phys:G",
		mods = "CTRL",
		timeout_milliseconds = 10000,
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
			mods = "LEADER",
			action = wezterm.action.SplitVertical({
				domain = "CurrentPaneDomain",
			}),
		},
		{
			key = "[",
			mods = "LEADER",
			action = wezterm.action.ActivateCopyMode,
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
}

bar.apply_to_config(config)

-- and finally, return the configuration to wezterm
return config
