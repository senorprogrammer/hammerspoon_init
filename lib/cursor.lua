-- -------------------- Cursor Locator --------------------
--
-- Sometimes I lose the cursor and I'm not a fan of the 'shake to show'
-- that's built into OS X. Paints a basic target around the cursor.
--
-- Someday I'll add fireworks.

function removeCircle(mouseCircle)
  mouseCircle:hide(0.25)
  hs.timer.doAfter(1, function() mouseCircle:delete() end)
end

function mouseHighlight()
  local red =   {["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1}
  local white = {["red"]=1,["blue"]=1,["green"]=1,["alpha"]=1}

  local radius = 40
  local diameter = (radius * 2)

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
  mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x - radius, mousepoint.y - radius, diameter, diameter))
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
