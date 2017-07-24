function showBrowser()
  -- local webview = hs.webview.new(hs.screen.primaryScreen():frame())
  local rect = hs.geometry.rect(30, 120, 900, 400)
  local webview = hs.webview.new(rect)
  webview:url("https://blockchain.info/ticker"):windowStyle({"titled", "closable", "resizable"}) :show()

  -- bring the webview to front
  hs.application.get("Hammerspoon"):activate()
end

-- showBrowser()
