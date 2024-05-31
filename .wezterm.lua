-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

config.font = wezterm.font("JetBrainsMono Nerd Font")

config.font = wezterm.font({
	family = "JetBrainsMono Nerd Font",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})

config.font_size = 14.0
config.color_scheme = "Catppuccin Mocha"
config.default_domain = "WSL:Ubuntu"
config.enable_tab_bar = false

-- and finally, return the configuration to wezterm
return config
