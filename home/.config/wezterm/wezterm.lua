local wezterm = require("wezterm")
local config = wezterm.config_builder()

local is_linux = function()
	return wezterm.target_triple:find("linux") ~= nil
end

config.font = wezterm.font("JetBrainsMono Nerd Font")
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

config.initial_cols = 124

local act = wezterm.action
config.keys = {
	-- paste from the clipboard
	{ key = "Insert", mods = "SHIFT", action = act.PasteFrom("Clipboard") },
	-- copy from the clipboard
	{ key = "Insert", mods = "CTRL", action = act.CopyTo("Clipboard") },
  -- claude annoyed me for this
  -- https://github.com/wezterm/wezterm/discussions/5856
  {key="Enter", mods="SHIFT", action=wezterm.action{SendString="\x1b\r"}},

}

-- For Neovim Zen Mode
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

-- The End
return config
