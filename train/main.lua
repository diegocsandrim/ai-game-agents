require("person")
require("seat")
require("wall")
require("platform")
require("influence")
require("parameter")
require("mapBuilder")
require("gameState")
require("stand")

local param, map, state

-- Do all startup here
function love.load()
  restart()
end

local frame = 0
local totalTime = 0

function love.update(dt)
  
  totalTime = totalTime + dt
  frame = frame + dt
  local frameTime = 0.03 / state.velocity
  
  if(frame < frameTime) then
    return
  else
    frame = frame - frameTime
  end

  if (state.step) then
    -- keep doing steps
  elseif (state.paused) then
    return
  end
  
  influence:UpdateV2(map)  

  for i=2,#map.people do
    local person = map.people[i]
    local direction = influence:GetDirection(person, map)

    person:Move(direction, param, influence)
  end

  local step = 3
  local person = map.people[1]
  local old_x = person.x
  local old_y = person.y

  local direction = {}
  direction.x = 0
  direction.y = 0

  if love.keyboard.isDown("up") then
    direction.y = -1
    --person.y = person.y - step
  end
  if love.keyboard.isDown("down") then
    direction.y = 1
    --person.y = person.y + step
  end
  if love.keyboard.isDown("left") then
    direction.x = -1
    --person.x = person.x - step
  end
  if love.keyboard.isDown("right") then
    direction.x = 1
    --person.x = person.x + step
  end
  
  

  person:Move(direction, param, influence)

  person.x = math.max(person.x, Person.width/2)
  person.x = math.min(person.x, love.graphics.getWidth() - Person.width/2)

  person.y = math.max(person.y, Person.height/2)
  person.y = math.min(person.y, love.graphics.getHeight() - Person.height/2)
  
  
  
end

-- Draw ONLY happens here
function love.draw()
  love.graphics.setColor(0,0,0,255)
  for i, wall in ipairs(map.walls) do
    wall.draw()
  end
  love.graphics.setColor(255,255,255,255)

  for i, seat in ipairs(map.seats) do
    seat.draw()
  end

  for i, person in ipairs(map.people) do
    person.draw()
  end

  
  local minValue = -5
  local maxValue = 5         
  local proportion = 255 / (maxValue-minValue)

  if(state.debug) then
    for x, column in ipairs(influence.influenceMap) do
        for y, cell in ipairs(column) do

            local value = influence.influenceMap[x][y]
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

  if(state.paused) then
    love.graphics.setColor(255,255,255,128)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    local x =  0
    local y =  love.graphics.getHeight()/2
    local limit =  love.graphics.getWidth()

    love.graphics.setNewFont(42)
    love.graphics.setColor(255,0,0,255)
    love.graphics.printf("PAUSED", x, y, love.graphics.getWidth(), "center" )
    y = y + 150

    x =love.graphics.getWidth() / 3
    love.graphics.setNewFont(16)
    love.graphics.setColor(255,0,0,255)
    love.graphics.printf("Controls", x, y, love.graphics.getWidth(), "left" )
    y = y + 16

    
    love.graphics.printf("p: pause/unpause", x, y, love.graphics.getWidth(), "left" )    
    y = y + 16
    
    love.graphics.printf("s: make small steps when paused", x, y, love.graphics.getWidth(), "left" )
    y = y + 16

    --d,p,s,r,+,-
    love.graphics.printf("d: debug, show the influence map", x, y, love.graphics.getWidth(), "left" )
    y = y + 16
        
    love.graphics.printf("r: restart the simulation", x, y, love.graphics.getWidth(), "left" )
    y = y + 16

    love.graphics.printf("+ or -, more or less velocity", x, y, love.graphics.getWidth(), "left" )
    y = y + 16

    love.graphics.printf("arrow up, down, left, right, control the blue person", x, y, love.graphics.getWidth(), "left" )
    y = y + 16

    love.graphics.setColor(255,255,255,255)
  end
  
  if(totalTime < 5) then
    love.graphics.setNewFont(32)
    love.graphics.setColor(255,0,0,255)
    love.graphics.printf("Press p to pause", 0, 0, love.graphics.getWidth(), "left" )
  end
end

-- Read the keyboard!
function love.keypressed(key)
  if key == 'd' then
    state.debug = not state.debug
  elseif key == 'p' then
    state.paused = not state.paused
  elseif key == 's' then
    state.step = true
  elseif key == 'r' then
    restart()
  elseif key == '+' or key == 'kp+' then
    state.velocity = state.velocity * 1.5
  elseif key == '-'or key == 'kp-' then
    state.velocity = state.velocity * 0.7
  else
    --print(key)
  end
end

function love.keyreleased(key)
  if key == 's' then
    state.step = false
  end
end

-- click to exit
function love.quit()
  print("Thanks for playing! Come back soon!")
end

function restart()
  local window_w = love.graphics.getWidth()
  local window_h = love.graphics.getHeight()
  
  param = Parameter:create()
  state = GameState:create(param)
  map = MapBuilder:create(param)
  
  influence = Influence:Create(param.influence.size.x, param.influence.size.y, window_w, window_h, map)
  
  love.graphics.setNewFont(12)
  love.graphics.setBackgroundColor(200,200,200)
end
