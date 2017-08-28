-- Displays the status of the firewall by putting dots into the toolbar
-- Green dots good, red dots bad
--
-- Largely cribbed from https://github.com/cmsj/hammerspoon-config/blob/master/statuslets.lua

local obj = {}
local interval = 2

obj.timer = nil
obj.firewallStealthDot = nil

hs.canvas.drawingWrapper(true)

function obj:render()
  local initialScreenFrame = hs.screen.allScreens()[1]:fullFrame()

  -- Start off by declaring the size of the text/circle objects and some anchor positions for them on screen
  local statusDotWidth = 8
  local statusDotOffset = 2
  local statusDotYVal = 2

  local xPos = self.xPosition(statusDotWidth, statusDotOffset)

  self.firewallEnabledDot = hs.drawing.circle(hs.geometry.rect(xPos,
                                                               self.yPosition(0, statusDotYVal, statusDotWidth, statusDotOffset),
                                                               statusDotWidth,
                                                               statusDotWidth))
  self.firewallStealthDot = hs.drawing.circle(hs.geometry.rect(xPos,
                                                               self.yPosition(1, statusDotYVal, statusDotWidth, statusDotOffset),
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
  local statusDotWidth = 8
  local statusDotOffset = 2
  local statusDotYVal = 2

  local xPos = self.xPosition(statusDotWidth, statusDotOffset)

  self.firewallEnabledDot:setTopLeft(hs.geometry.point(xPos, self.yPosition(0, statusDotYVal, statusDotWidth, statusDotOffset)))
  self.firewallStealthDot:setTopLeft(hs.geometry.point(xPos, self.yPosition(1, statusDotYVal, statusDotWidth, statusDotOffset)))

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
