local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font_with_fallback { 'Hack Nerd Font Mono', 'JetBrains Mono' }
config.font_size = 13
--config.color_scheme = 'Belge (terminal.sexy)'
config.color_scheme = 'Brogrammer'
config.hide_tab_bar_if_only_one_tab = true

return config