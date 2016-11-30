local style = {
  font = "Monoid",
  size = 10,
  color = { white = 1 },
}

local text = "This is a cat and a dog. "

local size = hs.drawing.getTextDrawingSize(text, style)

-- hs.drawing.text({}, text):setSize(size):
--   setTopLeft{ x = 4, y = 880 }:setTextStyle(style):show()
