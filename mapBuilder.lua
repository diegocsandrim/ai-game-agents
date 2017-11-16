require("util")
require("map")

MapBuilder = {}

function createPeople(param, map)
  local window_w = love.graphics.getWidth()
  local window_h = love.graphics.getHeight()

  local people = {}
  local index = 1
  while (index <= param.person.quantity) do
    
    local x = love.math.random(window_w - Person.width)
    local y = love.math.random(window_h - Person.height)
    
    local tile = Util.GetTileFromPosition(x, y, param)
    
    local item = map.index[tile.x][tile.y]

    if(item == 4) then
      local player = index == 1
      local tiredThreshold = love.math.random(10, 20)
      local person = Person:Create(x, y, param.person.influence, param.person.minStaticInfluence, param.person.influenceDist, tiredThreshold, param.person.influenceDecay, player)
      person:register(map)
      person:notifyObservers(nil, tile)
      people[index] = person
      
      index = index + 1
    end

  end
  for i=1, param.person.quantity do
    

    
  end
  return people
end

function MapBuilder:create(param)
  local window_w = love.graphics.getWidth()
  local window_h = love.graphics.getHeight()

  local objMap = {}
  
  objMap[01] = {4,4,4,4,4,4,2,2,2,2,2,2,2,2,4,4,4,4,4,4}
  objMap[02] = {4,4,4,4,4,4,2,2,2,2,2,2,2,2,4,4,4,4,4,4}
  objMap[03] = {4,4,4,4,4,4,2,1,8,8,8,8,1,2,4,4,4,4,4,4}
  objMap[04] = {4,4,4,4,4,4,2,1,8,8,8,8,1,2,4,4,4,4,4,4}
  objMap[05] = {4,4,4,4,4,4,8,8,8,8,8,8,8,8,4,4,4,4,4,4}
  objMap[06] = {4,4,4,4,4,4,8,8,8,8,8,8,8,8,4,4,4,4,4,4}
  objMap[07] = {4,4,4,4,4,4,2,1,8,8,8,8,1,2,4,4,4,4,4,4}
  objMap[08] = {4,4,4,4,4,4,2,1,8,8,8,8,1,2,4,4,4,4,4,4}
  objMap[09] = {4,4,4,4,4,4,2,1,1,8,8,1,1,2,4,4,4,4,4,4}
  objMap[10] = {4,4,4,4,4,4,8,8,8,8,8,8,8,8,4,4,4,4,4,4}
  objMap[11] = {4,4,4,4,4,4,8,8,8,8,8,8,8,8,4,4,4,4,4,4}
  objMap[12] = {4,4,4,4,4,4,2,1,1,8,8,1,1,2,4,4,4,4,4,4}
  objMap[13] = {4,4,4,4,4,4,2,1,8,8,8,8,1,2,4,4,4,4,4,4}
  objMap[14] = {4,4,4,4,4,4,2,1,8,8,8,8,1,2,4,4,4,4,4,4}
  objMap[15] = {4,4,4,4,4,4,8,8,8,8,8,8,8,8,4,4,4,4,4,4}
  objMap[16] = {4,4,4,4,4,4,8,8,8,8,8,8,8,8,4,4,4,4,4,4}
  objMap[17] = {4,4,4,4,4,4,2,1,8,8,8,8,1,2,4,4,4,4,4,4}
  objMap[18] = {4,4,4,4,4,4,2,1,8,8,8,8,1,2,4,4,4,4,4,4}
  objMap[19] = {4,4,4,4,4,4,2,1,1,8,8,1,1,2,4,4,4,4,4,4}
  objMap[20] = {4,4,4,4,4,4,8,8,8,8,8,8,8,8,4,4,4,4,4,4}
  objMap[21] = {4,4,4,4,4,4,8,8,8,8,8,8,8,8,4,4,4,4,4,4}
  objMap[22] = {4,4,4,4,4,4,2,1,8,8,8,8,1,2,4,4,4,4,4,4}
  objMap[23] = {4,4,4,4,4,4,2,1,8,8,8,8,1,2,4,4,4,4,4,4}
  objMap[24] = {4,4,4,4,4,4,2,1,1,8,8,1,1,2,4,4,4,4,4,4}
  objMap[25] = {4,4,4,4,4,4,8,8,8,8,8,8,8,8,4,4,4,4,4,4}
  objMap[26] = {4,4,4,4,4,4,8,8,8,8,8,8,8,8,4,4,4,4,4,4}
  objMap[27] = {4,4,4,4,4,4,2,1,8,8,8,8,1,2,4,4,4,4,4,4}
  objMap[28] = {4,4,4,4,4,4,2,1,8,8,8,8,1,2,4,4,4,4,4,4}
  objMap[29] = {4,4,4,4,4,4,2,2,2,2,2,2,2,2,4,4,4,4,4,4}
  objMap[30] = {4,4,4,4,4,4,2,2,2,2,2,2,2,2,4,4,4,4,4,4}

  local map = Map:create(objMap)

  influencew = window_w / param.influence.size.x
  influenceh = window_h / param.influence.size.y

  diffx = math.ceil(Seat.width / influencew) * influencew
  diffy = math.ceil(Seat.height / influenceh) * influenceh

  startatx = influencew * 3 + influencew/2
  startaty = influenceh * 20 + influenceh/2

  seatsIndex = 0
  wallIndex = 0
  pratformIndex = 0
  standIndex = 0
  
  map.seats = {}
  map.walls = {}
  map.platforms = {}
  map.stands = {}
  map.index = objMap
  
  for i, column in ipairs(objMap) do
    for j, type in ipairs(column) do
      if(type == 1) then
        seatsIndex = seatsIndex + 1
        map.seats[seatsIndex] = Seat:Create((i - 1) * influencew + influencew / 2, (j - 1) * influenceh + influenceh / 2, param.seat.influence, param.seat.influenceDist, param.seat.influenceDecay)
      elseif(type == 2) then
        wallIndex = wallIndex + 1
        map.walls[wallIndex] = Wall:Create((i - 1) * influencew, (j - 1) * influenceh, param.wall.influence, param.wall.influenceDist, param.wall.influenceDecay)
      elseif(type == 4) then
        pratformIndex = pratformIndex + 1
        map.platforms[pratformIndex] = Platform:Create((i - 1) * influencew, (j - 1) * influenceh, param.platform.influence, param.platform.influenceDist, param.platform.influenceDecay)
      elseif(type == 8) then
        standIndex = standIndex + 1
        map.stands[standIndex] = Stand:Create((i - 1) * influencew, (j - 1) * influenceh, param.stand.influence, param.stand.influenceDist, param.stand.influenceDecay)
      else
      end
    end
  end
  
  map.people = createPeople(param, map)
  
  return map
end
