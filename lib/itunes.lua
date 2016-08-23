-- -------------------- iTunes Control --------------------
--
-- Controls iTunes.

function displayCurrentTrack()
  local track = hs.itunes.getCurrentTrack()
  local artist = hs.itunes.getCurrentArtist()

  notify(track, artist)
end

-- Launch iTunes if it isn't already launched
hs.hotkey.bind({"alt", "ctrl"}, "i", function()
  hs.application.launchOrFocus("iTunes")
end)

-- Tell iTunes to play/pause
hs.hotkey.bind({"alt", "ctrl"}, "space", function()
  hs.itunes.playpause()
end)

-- Tell iTunes to play next track
hs.hotkey.bind({"alt", "ctrl"}, "x", function()
  hs.itunes.next()
  displayCurrentTrack()
end)

-- Tell iTunes to play prev track
hs.hotkey.bind({"alt", "ctrl"}, "z", function()
  hs.itunes.previous()
  displayCurrentTrack()
end)

-- Display information about the current track
hs.hotkey.bind({"alt", "ctrl"}, "c", function()
  displayCurrentTrack()
end)
