-- -------------------- UTC Menubar --------------------
--
-- See what time it is on the servers, right in the menubar (your servers are in UTC,
-- aren't they? If they aren't, no script will save you).

local utcMenu = hs.menubar.new()

function displayUTC(utcMenu)
  utcTime = os.date("!%H:%M:%S")
  utcMenu:setTitle(utcTime)
end

hs.timer.doEvery(1, function() displayUTC(utcMenu) end)
