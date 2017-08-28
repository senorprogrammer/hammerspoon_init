-- Displays the status of the firewall by putting dots into the toolbar
-- Green dots good, red dots bad
--
-- Largely cribbed from https://github.com/cmsj/hammerspoon-config/blob/master/statuslets.lua

local obj = {}
local interval = 5 -- in minutes

obj.timer = nil
obj.firewallStealthDot = nil

obj.statusDotWidth = 8
obj.statusDotOffset = 2
obj.statusDotYVal = 2

hs.canvas.drawingWrapper(true)

function obj:render()
  -- Initial positioning. Actual positioning is handled by :reposition()
  local initialRect = hs.geometry.rect(0, 0, self.statusDotWidth, self.statusDotWidth)

  self.firewallEnabledDot = hs.drawing.circle(initialRect)
  self.firewallStealthDot = hs.drawing.circle(initialRect)

  -- Drawing initialization
  local labels = {"canJoinAllSpaces", "stationary"}
  local level = "overlay"
  local defaultColor = hs.drawing.color.osx_yellow

  self.firewallEnabledDot:setBehaviorByLabels(labels):setFillColor(defaultColor):setStroke(false):sendToBack():show(0.5)
  self.firewallStealthDot:setBehaviorByLabels(labels):setFillColor(defaultColor):setStroke(false):sendToBack():show(0.5)

  self.firewallEnabledDot:setLevel(level)
  self.firewallStealthDot:setLevel(level)
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

function obj.xPosition(width, offset)
  local initialScreenFrame = hs.screen.allScreens()[1]:fullFrame()

  local xPos = initialScreenFrame.x + initialScreenFrame.w - width - offset
  return xPos
end

function obj.yPosition(idx, yVal, width, offset)
  local yPos = yVal + (idx * (width + offset))
  return yPos
end

-- This exists because windowing changes when the screen locks or the screensaver starts
-- play havoc with the positioning of the elements
function obj:reposition()
  -- I stack my dots vertically in the menubar so they have the same X value, and differ in the Y
  local xPos = self.xPosition(self.statusDotWidth, self.statusDotOffset)

  self.firewallEnabledDot:setTopLeft(hs.geometry.point(xPos, self.yPosition(0, self.statusDotYVal, self.statusDotWidth, self.statusDotOffset)))
  self.firewallStealthDot:setTopLeft(hs.geometry.point(xPos, self.yPosition(1, self.statusDotYVal, self.statusDotWidth, self.statusDotOffset)))

  return self
end

function obj:update()
  local proc = "/usr/libexec/ApplicationFirewall/socketfilterfw"
  hs.task.new(proc, self.statusletCallbackFirewallEnabled, {"--getglobalstate"}):start()
  hs.task.new(proc, self.statusletCallbackFirewallStealth, {"--getstealthmode"}):start()

  self:reposition()

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
