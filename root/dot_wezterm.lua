-- Pull in the wezterm API
local wezterm = require("wezterm")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local config = wezterm.config_builder()

local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Macchiato"
	else
		return "Catppuccin Latte"
	end
end

local function is_os(os)
	return string.lower(wezterm.target_triple):find(os) ~= nil
end

tabline.setup({
	options = {
		icons_enabled = true,
		theme = scheme_for_appearance(get_appearance()),
		tabs_enabled = true,
		section_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
	},
	sections = {
		tabline_a = { "mode" },
		tabline_b = { "workspace" },
		tab_active = {
			"index",
			{ "process", padding = { left = 0, right = 1 } },
		},
		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
		tabline_x = { "cpu", "ram" },
		tabline_y = { "datetime", "battery" },
		tabline_z = { "domain" },
	},
	extensions = {},
})

tabline.apply_to_config(config)

config = {
	color_scheme = scheme_for_appearance(get_appearance()),
	set_environment_variables = {
		PATH = "/opt/homebrew/bin" .. os.getenv("PATH"),
		SYSTEM_APPEARANCE = get_appearance(),
		WSL_ENV = "TERMINFO_DIRS:SYSTEM_APPEARANCE",
	},
	leader = {
		key = "phys:G",
		mods = "CTRL",
		timeout_milliseconds = 10000,
	},
	keys = { -- ... add these new entries to your config.keys table
		{
			key = "l",
			mods = "CMD|SHIFT",
			action = wezterm.action.ShowLauncher,
		},
		{
			-- I'm used to tmux bindings, so am using the quotes (") key to
			-- split horizontally, and the percent (%) key to split vertically.
			key = '"',
			-- Note that instead of a key modifier mapped to a key on your keyboard
			-- like CTRL or ALT, we can use the LEADER modifier instead.
			-- This means that this binding will be invoked when you press the leader
			-- (CTRL + A), quickly followed by quotes (").
			mods = "LEADER|SHIFT",
			action = wezterm.action.SplitVertical({
				domain = "CurrentPaneDomain",
			}),
		},
		{
			key = "%",
			mods = "LEADER",
			action = wezterm.action.SplitHorizontal({
				domain = "CurrentPaneDomain",
			}),
		},
		{
			key = "[",
			mods = "LEADER",
			action = wezterm.action.ActivateCopyMode,
		},
		{
			key = "h",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			key = "j",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Down"),
		},
		{
			key = "k",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Up"),
		},
		{
			key = "l",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
	},
	font = wezterm.font("Liga SFMono Nerd Font", {
		bold = false,
		italic = false,
		weight = "Regular",
	}),
	font_size = is_os("darwin") and 13.0 or 11.0,
	line_height = 1.4,
	use_fancy_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	hide_tab_bar_if_only_one_tab = false,
	tab_bar_at_bottom = false,
	scroll_to_bottom_on_input = true,
	default_prog = is_os("windows") and { "pwsh.exe" } or config.default_prog,
	window_background_opacity = 1.00,
	macos_window_background_blur = 100,
	win32_system_backdrop = "Tabbed",
	front_end = "WebGpu",
	window_frame = {
		font = wezterm.font({
			family = "Liga SFMono Nerd Font",
			weight = "Regular",
		}),
		font_size = is_os("darwin") and 13.0 or 11.0,
	},
	window_padding = {
		left = 6,
		right = 6,
		top = 6,
		bottom = 6,
	},
	-- term = "wezterm",
	window_decorations = is_os("darwin")
			and "MACOS_FORCE_ENABLE_SHADOW | TITLE | RESIZE | MACOS_USE_BACKGROUND_COLOR_AS_TITLEBAR_COLOR"
		or "INTEGRATED_BUTTONS | TITLE | RESIZE",
	integrated_title_button_style = is_os("darwin") and "MacOsNative" or is_os("linux") and "Gnome" or "Windows",
	native_macos_fullscreen_mode = true,
}

-- and finally, return the configuration to wezterm
return config
