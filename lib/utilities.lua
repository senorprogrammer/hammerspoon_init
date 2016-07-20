-- -------------------- Utility Functions --------------------

function buildRect(x, y, w, h)
  return hs.geometry.rect(x, y, w, h)
end

function focusedWin()
  return hs.window.focusedWindow()
end

function notify(title, text)
  hs.notify.new({ title = title, informativeText = text}):send()
end
