require("person")
require("seat")
require("wall")
require("platform")
require("influence")
require("parameter")

param = Parameter:create()
objects = {}

-- Do all startup here
function love.load()
  window_w = love.graphics.getWidth()
  window_h = love.graphics.getHeight()

  createObjects()

  influence = Influence:Create(param.influence.size.x, param.influence.size.y, window_w, window_h)
  influence:Update(objects)

  love.graphics.setNewFont(12)
  love.graphics.setBackgroundColor(200,200,200)
end

function createObjects()
  objects.people = {}

  for i=1, param.person.quantity do
    local x = love.math.random(window_w - Person.width)
    local y = love.math.random(window_h - Person.height)

    local tiredThreshold = love.math.random(10, 20)
    objects.people[i] = Person:Create(x, y, param.person.influence, param.person.minStaticInfluence, param.person.influenceDist, tiredThreshold)
  end

  objMap = {}

  objMap[01] = {3,3,3,0,0,0,2,2,2,2,2,2,2,2,2,0,0,0,3,3,3}
  objMap[02] = {3,0,0,0,0,0,2,2,2,2,2,2,2,2,2,0,0,0,0,0,3}
  objMap[03] = {3,0,0,0,0,0,2,1,0,0,0,0,0,1,2,0,0,0,0,0,3}
  objMap[04] = {3,0,0,0,0,0,2,1,0,0,0,0,0,1,2,0,0,0,0,0,3}
  objMap[05] = {3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3}
  objMap[06] = {3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3}
  objMap[07] = {3,0,0,0,0,0,2,1,0,0,0,0,0,1,2,0,0,0,0,0,3}
  objMap[08] = {3,0,0,0,0,0,2,1,0,0,0,0,0,1,2,0,0,0,0,0,3}
  objMap[09] = {3,0,0,0,0,0,2,1,1,0,0,0,1,1,2,0,0,0,0,0,3}
  objMap[10] = {3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3}
  objMap[11] = {3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3}
  objMap[12] = {3,0,0,0,0,0,2,1,1,0,0,0,1,1,2,0,0,0,0,0,3}
  objMap[13] = {3,0,0,0,0,0,2,1,0,0,0,0,0,1,2,0,0,0,0,0,3}
  objMap[14] = {3,0,0,0,0,0,2,1,0,0,0,0,0,1,2,0,0,0,0,0,3}
  objMap[15] = {3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3}
  objMap[16] = {3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3}
  objMap[17] = {3,0,0,0,0,0,2,1,0,0,0,0,0,1,2,0,0,0,0,0,3}
  objMap[18] = {3,0,0,0,0,0,2,1,0,0,0,0,0,1,2,0,0,0,0,0,3}
  objMap[19] = {3,0,0,0,0,0,2,1,1,0,0,0,1,1,2,0,0,0,0,0,3}
  objMap[20] = {3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3}
  objMap[21] = {3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3}
  objMap[22] = {3,0,0,0,0,0,2,1,0,0,0,0,0,1,2,0,0,0,0,0,3}
  objMap[23] = {3,0,0,0,0,0,2,1,0,0,0,0,0,1,2,0,0,0,0,0,3}
  objMap[24] = {3,0,0,0,0,0,2,1,1,0,0,0,1,1,2,0,0,0,0,0,3}
  objMap[25] = {3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3}
  objMap[26] = {3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3}
  objMap[27] = {3,0,0,0,0,0,2,1,0,0,0,0,0,1,2,0,0,0,0,0,3}
  objMap[28] = {3,0,0,0,0,0,2,1,0,0,0,0,0,1,2,0,0,0,0,0,3}
  objMap[29] = {3,0,0,0,0,0,2,2,2,2,2,2,2,2,2,0,0,0,0,0,3}
  objMap[30] = {3,3,3,0,0,0,2,2,2,2,2,2,2,2,2,0,0,0,3,3,3}



  objects.seats = {}
  objects.walls = {}
  objects.platforms = {}

  influencew = window_w / param.influence.size.x
  influenceh = window_h / param.influence.size.y

  diffx = math.ceil(Seat.width / influencew) * influencew
  diffy = math.ceil(Seat.height / influenceh) * influenceh

  startatx = influencew * 3 + influencew/2
  startaty = influenceh * 20 + influenceh/2

  seatsIndex = 0
  wallIndex = 0
  pratformIndex = 0
  for i, column in ipairs(objMap) do
    for j, type in ipairs(column) do
      if(type == 1) then
        seatsIndex = seatsIndex + 1
        objects.seats[seatsIndex] = Seat:Create((i - 1) * influencew + influencew / 2, (j - 1) * influenceh + influenceh / 2, param.seat.influence, param.seat.influenceDist)
      elseif(type == 2) then
        wallIndex = wallIndex + 1
        objects.walls[wallIndex] = Wall:Create((i - 1) * influencew, (j - 1) * influenceh, param.wall.influence, param.wall.influenceDist)
      elseif(type == 3) then
        pratformIndex = pratformIndex + 1
        objects.platforms[pratformIndex] = Platform:Create((i - 1) * influencew, (j - 1) * influenceh, param.platform.influence, param.platform.influenceDist)
      else
      end
    end
  end

end

-- Update the things here
function love.update(dt)
  influence:Update(objects)
  

  for i=2,#objects.people do
    local person = objects.people[i]
    local direction = influence:GetDirection(person)

    person:Move(direction)    
  end

  local step = 3
  local person = objects.people[1]
  local old_x = person.x
  local old_y = person.y

  if love.keyboard.isDown("up") then
    person.y = person.y - step
  end
  if love.keyboard.isDown("down") then
    person.y = person.y + step
  end
  if love.keyboard.isDown("left") then
    person.x = person.x - step
  end
  if love.keyboard.isDown("right") then
    person.x = person.x + step
  end

  person.x = math.max(person.x, Person.width/2)
  person.x = math.min(person.x, window_w - Person.width/2)

  person.y = math.max(person.y, Person.height/2)
  person.y = math.min(person.y, window_h - Person.height/2)

end

-- Draw ONLY happens here
function love.draw() 
        
  love.graphics.setColor(0,0,0,255)
  for i, wall in ipairs(objects.walls) do
    wall.draw()
  end
  love.graphics.setColor(255,255,255,255)

  for i, seat in ipairs(objects.seats) do
    seat.draw()
  end

  for i, person in ipairs(objects.people) do
    person.draw()
  end

  
  local minValue = -50
  local maxValue = 50            
  local proportion = 255 / (maxValue-minValue)

  if(param.debug) then
    for x, column in ipairs(influence.map) do
        for y, cell in ipairs(column) do

            local value = influence.map[x][y]
            local color = (value - minValue) * proportion
            color = math.min(255, color)
            color = math.max(0, color)

            local position = influence:GetStartPositionFromTile(x, y)
            local size = influence:GetTileSize()
            love.graphics.setColor(color, color, color, 127)
            love.graphics.rectangle("fill", position.x, position.y, size.w, size.h)
        end
    end
    love.graphics.setColor(255,255,255,255)
  end
  
end

-- Mouse pressed!
function love.mousepressed(x, y, button, istouch)
  if button == 1 then
     imgx = x -- move image to where mouse clicked
     imgy = y
  end
end

-- Mouse released!
function love.mousereleased(x, y, button, istouch)
  if button == 1 then
     --fireSlingshot(x,y) -- this totally awesome custom function is defined elsewhere
  end
end

-- Read the keyboard!
function love.keypressed(key)
  if key == 'd' then
    param.debug = not param.debug
  elseif key == 'f3' then
    --do work
  end
end

-- check the windows focus
function love.focus(f)
  if not f then
    --print("LOST FOCUS")
  else
    --print("GAINED FOCUS")
  end
end

-- click to exit
function love.quit()
  print("Thanks for playing! Come back soon!")
end
