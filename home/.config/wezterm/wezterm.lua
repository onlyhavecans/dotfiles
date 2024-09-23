local wezterm = require("wezterm")
local config = wezterm.config_builder()

local is_linux = function()
	return wezterm.target_triple:find("linux") ~= nil
end

config.font = wezterm.font("PragmataProMonoLiga Nerd Font")
config.font_size = is_linux() and 13.0 or 16.0
config.freetype_load_target = "Light"

config.color_scheme = "Gruvbox Dark (Gogh)"

config.use_resize_increments = true
config.hide_tab_bar_if_only_one_tab = true
config.enable_scroll_bar = false
config.window_padding = {
	left = "2px",
	right = "2px",
	top = "1px",
	bottom = "1px",
}

config.initial_cols = 150
config.initial_rows = 60

return config
