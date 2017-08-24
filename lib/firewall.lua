-- Displays the status of the firewall by putting dots into the toolbar
-- Green dots good, red dots bad
--
-- Largely cribbed from https://github.com/cmsj/hammerspoon-config/blob/master/statuslets.lua

local obj = {}
local interval = 2

obj.timer = nil
obj.firewallStealthText = nil
obj.firewallStealthDot = nil

hs.canvas.drawingWrapper(true)

function obj:render()
  local initialScreenFrame = hs.screen.allScreens()[1]:fullFrame()

  -- Start off by declaring the size of the text/circle objects and some anchor positions for them on screen
  local statusDotWidth = 8
  local statusDotOffset = 2
  local statusDot_x = initialScreenFrame.x + initialScreenFrame.w - statusDotWidth - statusDotOffset
  local statusDot_y = 2

  self.firewallEnabledDot = hs.drawing.circle(hs.geometry.rect(statusDot_x,
                                                               statusDot_y + (0 * (statusDotWidth + statusDotOffset)),
                                                               statusDotWidth,
                                                               statusDotWidth))
  self.firewallStealthDot = hs.drawing.circle(hs.geometry.rect(statusDot_x,
                                                               statusDot_y + (1 * (statusDotWidth + statusDotOffset)),
                                                               statusDotWidth,
                                                               statusDotWidth))

  self.firewallEnabledDot:setBehaviorByLabels({"canJoinAllSpaces", "stationary"}):setFillColor(hs.drawing.color.osx_yellow):setStroke(false):sendToBack():show(0.5)
  self.firewallEnabledDot:setLevel("overlay")
  self.firewallStealthDot:setBehaviorByLabels({"canJoinAllSpaces", "stationary"}):setFillColor(hs.drawing.color.osx_yellow):setStroke(false):sendToBack():show(0.5)
  self.firewallStealthDot:setLevel("overlay")
end

function obj.statusletCallbackFirewallEnabled(code, stdout, stderr)
  local color

  if string.find(stdout, "enabled") then
    color = hs.drawing.color.osx_green
  else
    color = hs.drawing.color.osx_red
  end

  obj.firewallEnabledDot:setFillColor(color)
end

function obj.statusletCallbackFirewallStealth(code, stdout, stderr)
  local color

  if string.find(stdout, "enabled") then
    color = hs.drawing.color.osx_green
  else
    color = hs.drawing.color.osx_red
  end

  obj.firewallStealthDot:setFillColor(color)
end

function obj:update()
  local proc = "/usr/libexec/ApplicationFirewall/socketfilterfw"
  hs.task.new(proc, self.statusletCallbackFirewallEnabled, {"--getglobalstate"}):start()
  hs.task.new(proc, self.statusletCallbackFirewallStealth, {"--getstealthmode"}):start()
  return self
end

-- Render our statuslets, trigger a timer to update them regularly, and do an initial update
function obj:start()
  self:render()
  self.timer = hs.timer.new(hs.timer.minutes(interval), function(obj) obj:update() end)
  self.timer:start()
  self:update()
  return self
end

function obj:stop()
  self.timer:stop()
  self.firewallEnabledDot:delete()
  self.firewallStealthDot:delete()
  return self
end

obj:start()
return obj
