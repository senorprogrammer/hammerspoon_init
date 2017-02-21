-- -------------------- DNS Menu --------------------
--
-- Drop-down menu listing your current DNS servers, if any.

local dnsMenu = hs.menubar.new()

function displayDns(dnsMenu)
  local handle = io.popen("networksetup -getdnsservers Wi-Fi")
  local servers = handle:read("*a")
  handle:close()

  local menu_items = {}

  for dns in string.gmatch(servers, "%S+") do
    table.insert(menu_items, { title = dns })
  end

  dnsMenu:setTitle("DNS")
  dnsMenu:setMenu(menu_items)
end

-- Make the menu show up on reload
displayDns(dnsMenu)

-- And refresh it every so often
hs.timer.doEvery(60, function() displayDns(dnsMenu) end)
