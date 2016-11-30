local key  = os.getenv("OPS_GENIE_API")
local team = os.getenv("OPS_GENIE_TEAM")
local url  = ("https://api.opsgenie.com/v1.1/json/schedule/whoIsOnCall" .. "?" .. "apiKey=" .. key .. "&name=" .. team)

-- Fetching

local status, body, headers = hs.http.get(url, nil)

-- Parsing

local json = hs.json.decode(body)
local on_call = json["participants"][1]["name"]

-- Drawing

function drawStr(str, x, y, delay)
  local grey = { red = 0.3, green = 0.3, blue = 0.3 }
  local style = { font = "Monoid", size = 10, color = grey }
  local size  = hs.drawing.getTextDrawingSize((str .. " "), style)

  text = hs.drawing.text({}, (str .. " ")):setSize(size):setTopLeft{ x = x, y = y }:setTextStyle(style):show()

  hs.timer.doAfter(delay, function() text:delete() end)
end

function drawOnCall()
  drawStr(("on-call: " .. on_call), 2, 880, 2)
end

-- Key Bindings

k = hs.hotkey.modal.new({"shift", "alt"}, 'G')

k:bind({}, '1', function() drawOnCall() k:exit() end)
