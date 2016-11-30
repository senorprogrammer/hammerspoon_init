local key = os.getenv("OPS_GENIE_API")
local team = os.getenv("OPS_GENIE_TEAM")
local url = ("https://api.opsgenie.com/v1.1/json/schedule/whoIsOnCall" .. "?" .. "apiKey=" .. key .. "&name=" .. team)

-- Fetching

local status, body, headers = hs.http.get(url, nil)

-- Parsing

local json = hs.json.decode(body)
local on_call = json["participants"][1]["name"]

-- Drawing

function drawStr(str, x, y)
  local grey = { red = 0.3, green = 0.3, blue = 0.3 }
  local style = { font = "Monoid", size = 10, color = grey }
  local size  = hs.drawing.getTextDrawingSize((str .. " "), style)

  hs.drawing.text({}, (str .. " ")):setSize(size):setTopLeft{ x = x, y = y }:setTextStyle(style):show()
end

drawStr(("on-call: " .. on_call), 2, 880)
