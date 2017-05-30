-- -------------------- Volume Control --------------------
--
-- Restores keyboard-based volume control. The touchbar in new Mac laptops
-- is pretty crap for this sort of thing.
--

local Audio = require 'lib.audio'

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "z", Audio.decVolume)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "x", Audio.incVolume)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "space", Audio.toggleMute)
