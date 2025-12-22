require('hs.ipc')

hs.hotkey.bind({ 'ctrl', 'shift' }, '`', function()
  local app = hs.application.get('com.github.wez.wezterm')

  if app then
    if app:isFrontmost() then
      app:hide()
    else
      app:activate()
    end
  else
    hs.task.new('/usr/bin/open', nil, {
      '-a', '/Applications/WezTerm.app',
      '--args', 'connect', 'wuake'
    }):start()
  end
end)
