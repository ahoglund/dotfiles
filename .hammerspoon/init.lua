hs.hotkey.alertDuration = 0
hs.hints.showTitleThresh = 0
hs.window.animationDuration = 0

hs.hotkey.bind({"shift", "alt"}, "J", function()
  local win    = hs.window.focusedWindow()
  local f      = win:frame()
  local screen = win:screen()
  local max    = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"shift", "alt"}, "L", function()
  local win    = hs.window.focusedWindow()
  local f      = win:frame()
  local screen = win:screen()
  local max    = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"shift", "alt"}, "K", function()
  local win    = hs.window.focusedWindow()
  local f      = win:frame()
  local screen = win:screen()
  local max    = screen:frame()

  f.x = max.x
  f.y = max.y
  f.h = max.h
  f.w = max.w
  win:setFrame(f)
end)

hs.hotkey.bind({"shift", "alt"}, "U", function()
  local win    = hs.window.focusedWindow()
  local f      = win:frame()
  local screen = win:screen()
  local max    = screen:frame()

  f.x = max.x / 2
  f.y = max.y / 2
  f.h = max.h / 2
  f.w = max.w / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"shift", "alt"}, "O", function()
  local win    = hs.window.focusedWindow()
  local f      = win:frame()
  local screen = win:screen()
  local max    = screen:frame()

  f.x = max.x + ( max.w / 2)
  f.y = max.y / 2
  f.h = max.h / 2
  f.w = max.w / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"shift", "alt"}, "N", function()
  local win    = hs.window.focusedWindow()
  local f      = win:frame()
  local screen = win:screen()
  local max    = screen:frame()

  f.x = max.x / 2
  f.y = max.y + (max.h / 2)
  f.h = max.h / 2
  f.w = max.w / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"shift", "alt"}, ",", function()
  local win    = hs.window.focusedWindow()
  local f      = win:frame()
  local screen = win:screen()
  local max    = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y + (max.h / 2)
  f.h = max.h / 2
  f.w = max.w / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"shift", "alt"}, "M", function()
  local win    = hs.window.focusedWindow()
  local f      = win:frame()
  local screen = win:screen()
  local max    = screen:frame()

  f.x = max.x + (max.w / 3.33)
  f.y = max.y
  f.h = max.h
  f.w = max.w / 2
  win:setFrame(f)
end)
