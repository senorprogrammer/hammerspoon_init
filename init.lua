-- http://www.hammerspoon.org/go/


--hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  --hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
--end)

function alert(title, text)
  hs.notify.new({ title = title, informativeText = text}):send()
end

-- -------------------- Config Reload --------------------
--
-- Watches this file for changes and automatically reloads them.
-- I've had limited success with this; sometimes it seems not to catch the changes.
-- I should map a keyboard shortcut to reload as well....

function reloadConfig(files)
    doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.notify.new({ title = "Hammerspoon", informativeText = "Config loaded" }):send()

-- -------------------- UTC Menubar --------------------
--
-- See what time it is on the servers, right in the menubar (your servers are in UTC,
-- aren't they? If they aren't, no script will save you).

local utcMenu = hs.menubar.new()

function setTime(utcMenu)
  utcTime = os.date("!%H:%M:%S")
  utcMenu:setTitle(utcTime)
end

hs.timer.doEvery(1, function() setTime(utcMenu) end)

-- -------------------- iTunes Control --------------------
--
-- Controls iTunes. Adds play/pause, next track, and prev track.

-- Tell iTunes to play/pause
hs.hotkey.bind({"alt", "ctrl"}, "space", function()
  hs.itunes.playpause()
end)

-- Tell iTunes to play next track
hs.hotkey.bind({"alt", "ctrl"}, "x", function()
  hs.itunes.next()
  alert("Now playing:", hs.itunes.getCurrentTrack())
end)

-- Tell iTunes to play prev track
hs.hotkey.bind({"alt", "ctrl"}, "z", function()
  hs.itunes.previous()
  alert("Now playing:", hs.itunes.getCurrentTrack())
end)

-- -------------------- Window Management --------------------

hs.hotkey.bind({"shift", "alt"}, "D", function()
  alert("DEBUG", "D")
end)

-- -------------------- Mouse Locator --------------------
--
-- Sometimes I lose the cursor and I'm not a fan of the 'shake to show'
-- that's built into OS X. Paints a basic target around the cursor.
--
-- Someday I'll add fireworks.

local mouseCircle = nil
local mouseCircleTimer = nil

local red =   {["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1}
local white = {["red"]=1,["blue"]=1,["green"]=1,["alpha"]=1}

function removeCircle(mouseCircle)
  mouseCircle:hide(0.25)
  hs.timer.doAfter(1, function() mouseCircle:delete() end)
end

function mouseHighlight()
    -- Delete an existing highlight if it exists
    if mouseCircle then
        removeCircle(mouseCircle)

        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end

    -- Get the current co-ordinates of the mouse pointer
    mousepoint = hs.mouse.getAbsolutePosition()

    -- Prepare a circle around the mouse pointer
    mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x - 20, mousepoint.y - 20, 40, 40))
    mouseCircle:setStrokeColor(red)
    mouseCircle:setFill(true)
    mouseCircle:setStrokeWidth(1)
    mouseCircle:setAlpha(.5)
    mouseCircle:setFillGradient(red, white, 90)
    mouseCircle:show()

    -- Set a timer to delete the circle
    mouseCircleTimer = hs.timer.doAfter(0.75, function() removeCircle(mouseCircle) end)
end

hs.hotkey.bind({"cmd","alt","ctrl"}, "M", mouseHighlight)
