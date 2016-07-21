-- -------------------- Window Management --------------------

k = hs.hotkey.modal.new({"shift", "alt"}, 'D')

function k:entered() end
function k:exited() end

function halfLeft()
  local win    = focusedWin()
  local max    = win:screen():frame()
  local frame  = buildRect(max.x, max.y, (max.w * 0.5), max.h)

  fastFrame(win, frame)
end

function halfRight()
  local win    = focusedWin()
  local max    = win:screen():frame()
  local frame  = buildRect((max.x + (max.w * 0.5)), max.y, max.w / 2, max.h)

  fastFrame(win, frame)
end

function threeQuartersLeft()
  local win    = focusedWin()
  local max    = win:screen():frame()
  local frame  = buildRect(max.x, max.y, (max.w * 0.75), max.h)

  fastFrame(win, frame)
end

function fullScreen()
  local win    = focusedWin()
  local max    = win:screen():frame()
  local frame  = buildRect(max.x, max.y, max.w, max.h)

  fastFrame(win, frame)
end

function fastFrame(window, frame)
  window:setFrame(frame, 0)
end


-- My needs for window arrangement are pretty simple
k:bind({}, '1',      function() halfLeft()          k:exit() end)
k:bind({}, '2',      function() halfRight()         k:exit() end)
k:bind({}, '3',      function() threeQuartersLeft() k:exit() end)
k:bind({}, '0',      function() fullScreen()        k:exit() end)
k:bind({}, 'escape', function()                     k:exit() end)

