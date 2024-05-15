-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

config.font = wezterm.font("JetBrainsMono Nerd Font")

config.font_size = 14.0
config.color_scheme = "Catppuccin Mocha"
config.default_domain = "WSL:Ubuntu"
config.enable_tab_bar = false

-- and finally, return the configuration to wezterm
return config
