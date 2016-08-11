-- -------------------- iTunes Control --------------------
--
-- Controls iTunes.

-- Tell iTunes to play/pause
hs.hotkey.bind({"alt", "ctrl"}, "space", function()
  hs.itunes.playpause()
end)

-- Tell iTunes to play next track
hs.hotkey.bind({"alt", "ctrl"}, "x", function()
  hs.itunes.next()
  notify("Now playing:", hs.itunes.getCurrentTrack())
end)

-- Tell iTunes to play prev track
hs.hotkey.bind({"alt", "ctrl"}, "z", function()
  hs.itunes.previous()
  notify("Now playing:", hs.itunes.getCurrentTrack())
end)

-- Display information about the current track
hs.hotkey.bind({"alt", "ctrl"}, "c", function()
  hs.itunes.displayCurrentTrack()
end)
