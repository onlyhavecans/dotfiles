local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font("PragmataProMonoLiga Nerd Font")
config.font_size = 16.0
config.freetype_load_target = "Light"

config.color_scheme = "Gruvbox Dark (Gogh)"
-- config.color_scheme = "Catppuccin Mocha"

config.hide_tab_bar_if_only_one_tab = true

return config
