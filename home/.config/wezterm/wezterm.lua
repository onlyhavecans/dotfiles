local wezterm = require("wezterm")
local config = wezterm.config_builder()

local is_linux = function()
	return wezterm.target_triple:find("linux") ~= nil
end

config.font = wezterm.font("PragmataProMonoLiga Nerd Font")
config.font_size = is_linux() and 13.0 or 16.0
config.freetype_load_target = "Light"

config.color_scheme = "Gruvbox Dark (Gogh)"

config.hide_tab_bar_if_only_one_tab = true
config.enable_scroll_bar = false

config.initial_cols = is_linux() and 80 or 155
config.initial_rows = is_linux() and 40 or 72

return config
