Util = {}

function Util.GetTileFromPosition(x, y, param)
  local window_w = love.graphics.getWidth()
  local window_h = love.graphics.getHeight()

  local mapx = math.floor(param.influence.size.x * x / window_w) + 1
  local mapy = math.floor(param.influence.size.y * y / window_h) + 1

  local mapx = math.min(mapx, param.influence.size.x)
  local mapy = math.min(mapy, param.influence.size.y)

  local position = {}
  position.x = mapx
  position.y = mapy

  return position
end
