local wezterm = require 'wezterm'
local config = {
  font = wezterm.font_with_fallback { 'Hack Nerd Font Mono', 'JetBrains Mono' },
  font_size = 13,
  -- color_scheme = 'Belge (terminal.sexy)',
  color_scheme = 'Brogrammer',
  hide_tab_bar_if_only_one_tab = true,
  initial_rows = 80,
  initial_cols = 200,
};

return config