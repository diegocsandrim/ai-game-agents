require("person")
require("influence")

debug = true

-- Do all startup here
function love.load()
  window_w = love.graphics.getWidth()
  window_h = love.graphics.getHeight()

  objects = {}
  objects.people = {}
  influence = Influence:Create(32, 32, window_w, window_h)

  for i=1, 20 do
    local x = love.math.random(window_w - Person.width)
    local y = love.math.random(window_h - Person.height)
    
    objects.people[i] = Person:Create(x, y, -1, 1)
    --objects.people[i] = Person:Create(window_w/2, window_h/2, 1)
  end
  
  influence:Update(objects)

  love.graphics.setNewFont(12)
  love.graphics.setBackgroundColor(200,200,200)
end

-- Update the things here
function love.update(dt)
  influence:Update(objects)

  for i=2,#objects.people do
    local person = objects.people[i]
    local direction = influence:GetDirection(person)

    person:Move(direction)    
  end

  local step = 1
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
  local maxValue = -math.huge;
  local minValue = math.huge;

  for x, column in ipairs(influence.map) do
    for y, cell in ipairs(column) do
        local value = influence.map[x][y]
        maxValue = math.max(maxValue, value)
        minValue = math.min(minValue, value)
    end
  end

  local proportion = 255 / (maxValue-minValue)

  if(debug) then
    for x, column in ipairs(influence.map) do
        for y, cell in ipairs(column) do
            local value = influence.map[x][y]
            local color = (value - minValue) * proportion
            local position = influence:GetStartPositionFromTile(x, y)
            local size = influence:GetTileSize()
            love.graphics.setColor(color, color, color, 127)
            love.graphics.rectangle("fill", position.x, position.y, size.w, size.h)

            love.graphics.setColor(0, 0, color)
            love.graphics.print(value, position.x, position.y)
        end
    end
  end

    for i, person in ipairs(objects.people) do
      person.draw(image)
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
    debug = not debug
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
