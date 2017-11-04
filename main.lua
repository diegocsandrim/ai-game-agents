require("person")
require("influence")

-- Do all startup here
function love.load()
  window_w = love.graphics.getWidth()
  window_h = love.graphics.getHeight()
  
  objects = {}
  objects.people = {}
  influence = Influence:Create(128, 128, window_w, window_h)

  for i=1, 20 + 1 do
    local x = love.math.random(window_w - Person.width)
    local y = love.math.random(window_h - Person.height)
    
    objects.people[i] = Person:Create(x, y, 1)
  end
  
  objects.players = {}
  objects.player.first = Person:Create(window_w/2, window_h/2, 1)

  influence:Update(objects)

  image = love.graphics.newImage(Person.image)
  love.graphics.setNewFont(12)
  love.graphics.setBackgroundColor(200,200,200)
end

-- Update the things here
function love.update(dt)
  influence:Update(objects)

  for i=1,#objects.people do
    local person = objects.people[i]
    person:Move(influence)    
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

  if(person.x + Person.width > window_w or person.x < 0) then
    person.x = old_x
  end

  if(person.y + Person.height > window_h or person.y < 0) then
    person.y = old_y
  end

  
  for i, person in ipairs(objects.people) do
    love.graphics.draw(image, person.x, person.y)
  end

end

-- Draw ONLY happens here
function love.draw()
  for i, person in ipairs(objects.people) do
    love.graphics.draw(image, person.x, person.y)
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
  if key == 'b' then
  elseif key == 'a' then
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
