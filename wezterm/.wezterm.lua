local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback { 'FiraCode Nerd Font', 'FiraCode', 'CaskaydiaCove Nerd Font Mono' }
config.font_size = 12
config.color_scheme = 'OneHalfDark'

config.front_end = 'WebGpu'
config.webgpu_power_preference = 'HighPerformance'
config.scrollback_lines = 10000

config.initial_cols = 120
config.initial_rows = 28
config.window_decorations = 'RESIZE'
config.window_padding = {
  left = 2,
  right = 2,
  top = 0,
  bottom = 0,
}
config.window_close_confirmation = 'NeverPrompt'

-- Wuake: dropdown terminal module
-- Usage: wezterm connect wuake
-- Source: https://gist.github.com/xieve/fc67361a2a0cb8fc23ab8369a8fc1170
local wuake = (function()
  local module = {}
  local data_dir = (os.getenv('XDG_DATA_HOME') or wezterm.home_dir .. '/.local/share') .. '/wezterm/'
  local pidfile_path = data_dir .. 'wuake_pid'
  local last_exit_path = data_dir .. 'wuake_last_exit'
  local pid = wezterm.procinfo.pid()

  local function read_file(file_path)
    local f = io.open(file_path)
    if f ~= nil then
      local s = f:read()
      f:close()
      return s
    end
  end

  local function write_file(file_path, s)
    local f = io.open(file_path, 'w')
    if f then
      f:write(s)
      f:close()
    end
  end

  local function read_pidfile()
    return read_file(pidfile_path)
  end

  function module.setup(params)
    local default_params = {
      margin_left = 0,
      margin_top = 0,
      margin_right = 0,
      margin_bottom = 0,
      width_factor = 1,
      height_factor = params.margin_bottom and 1 or 0.4,
      domain = 'wuake',
      create_unix_domain = not params.domain,
      config_overrides = {},
    }

    for key, value in pairs(default_params) do
      params[key] = params[key] or value
    end

    if params.create_unix_domain then
      params.config.unix_domains = params.config.unix_domains or {}
      table.insert(params.config.unix_domains, { name = params.domain })
    end

    local function close_dropdown()
      write_file(last_exit_path, wezterm.time.now():format('%s%.f'))
      os.exit()
    end

    wezterm.on('update-status', function(window)
      if wezterm.GLOBAL.wuake_setup_done then return end

      local this_proc_info = wezterm.procinfo.get_info_for_pid(pid)
      if this_proc_info.argv[2] ~= 'connect' or this_proc_info.argv[3] ~= params.domain then
        -- not a wuake window
      else
        local now = tonumber(wezterm.time.now():format('%s%.f'))
        local pid_info = wezterm.procinfo.get_info_for_pid(read_pidfile() or 0)
        local last_exit = read_file(last_exit_path)

        local is_wuake_running = pid_info and pid_info.name == 'wezterm-gui'
        local recently_exited = last_exit and (now - tonumber(last_exit)) < 0.5
        if not is_wuake_running and not recently_exited then
          write_file(pidfile_path, tostring(pid))
          local screens = wezterm.gui.screens()
          window:set_position(screens.active.x + params.margin_left, screens.active.y + params.margin_top)
          window:set_inner_size(
            screens.active.width * params.width_factor - params.margin_right - params.margin_left,
            screens.active.height * params.height_factor - params.margin_bottom - params.margin_top
          )
          window:set_config_overrides(params.config_overrides)
        else
          os.remove(pidfile_path)
          close_dropdown()
        end
      end
      wezterm.GLOBAL.wuake_setup_done = true
    end)

    if params.close_on_focus_loss then
      wezterm.on('window-focus-changed', function(window, pane)
        if pane:get_domain_name() == params.domain and not window:is_focused() then
          close_dropdown()
        end
      end)
    end
  end

  return module
end)()

wuake.setup {
  config = config,
  height_factor = 0.4,
  config_overrides = {
    window_decorations = 'NONE',
    window_padding = { left = 4, right = 4, top = 4, bottom = 4 },
    window_level = 'AlwaysOnTop',
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
