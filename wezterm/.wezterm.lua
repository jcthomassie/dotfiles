local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback { 'FiraCode Nerd Font', 'FiraCode', 'CaskaydiaCove Nerd Font Mono' }
config.font_size = 12
config.color_scheme = 'OneHalfDark'

local is_macos = wezterm.target_triple:find('apple%-darwin') ~= nil

if is_macos then
  config.front_end = 'WebGpu'
  config.webgpu_power_preference = 'HighPerformance'
  config.window_decorations = 'RESIZE'
else
  config.window_decorations = 'NONE'
  config.window_frame = {
    border_left_width = '0.1cell',
    border_right_width = '0.1cell',
    border_bottom_height = '0.05cell',
    border_top_height = '0.05cell',
    border_left_color = '#212121',
    border_right_color = '#212121',
    border_bottom_color = '#212121',
    border_top_color = '#212121',
  }
end
config.scrollback_lines = 10000

-- Workaround for Flatpak close confirmation bug
wezterm.on('mux-is-process-stateful', function(proc)
  return false
end)

config.initial_cols = 120
config.initial_rows = 28
config.window_padding = {
  left = 2,
  right = 2,
  top = 0,
  bottom = 0,
}
config.window_close_confirmation = 'NeverPrompt'

config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'NONE',
    action = wezterm.action.ScrollByLine(-1),
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'NONE',
    action = wezterm.action.ScrollByLine(1),
  },
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'SHIFT',
    action = wezterm.action.ScrollByLine(-5),
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'SHIFT',
    action = wezterm.action.ScrollByLine(5),
  },
}

config.keys = {
  {
    key = 'Enter',
    mods = 'SHIFT',
    action = wezterm.action { SendString = '\x1b\r' },
  },
  {
    key = 'n',
    mods = 'SUPER',
    action = wezterm.action.SpawnWindow,
  },
  {
    key = 't',
    mods = 'SUPER',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'd',
    mods = 'SUPER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'd',
    mods = 'SUPER|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'P',
    mods = 'SUPER',
    action = wezterm.action.ActivateCommandPalette,
  },
  {
    key = 'w',
    mods = 'SUPER',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
  {
    key = 'w',
    mods = 'SUPER|SHIFT',
    action = wezterm.action.CloseCurrentTab { confirm = false },
  },
  {
    key = 'q',
    mods = 'SUPER',
    action = wezterm.action.QuitApplication,
  },
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'UpArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'Space',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.QuickSelect,
  },
}

return config
