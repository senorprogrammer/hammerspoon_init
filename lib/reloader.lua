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
notify("Hammerspoon", "Config loaded.")
