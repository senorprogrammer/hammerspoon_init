-- -------------------- UTC Menubar --------------------
--
-- See what time it is on the servers, right in the menubar (your servers are in UTC,
-- aren't they? If they aren't, no script will save you).

local utcMenu = hs.menubar.new()

function displayUTC(utcMenu)
  utcTime = os.date("!%H:%M")
  utcMenu:setTitle("UTC " .. utcTime)
end

-- Make the menu show up on load
displayUTC(utcMenu)

-- And refresh it every so often (I don't care about seconds)
hs.timer.doEvery(30, function() displayUTC(utcMenu) end)
