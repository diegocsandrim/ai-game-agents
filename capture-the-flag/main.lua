require("splash")
-- require("person")
-- require("flag")
-- require("field")
-- require("base")
-- require("map")
require("state_control")

local stateControl = StateControl:create()

function love.load()
  setWindowProperties()
    
  local splash = Splash:create()
  splash:register(stateControl)
  stateControl:set(splash)
end

function love.update(dt)
  local currentState = stateControl:get()
  
  if currentState.update then
    currentState:update(dt)
  end
end

-- Draw ONLY happens here
function love.draw()
  local currentState = stateControl:get()
  
  if currentState.draw then
    currentState:draw()
  end
end

-- Mouse pressed!
function love.mousepressed(x, y, button, istouch)
  local currentState = stateControl:get()
  
  if currentState.mousepressed then
    currentState:mousepressed(x, y, button, istouch)
  end
end

-- Mouse released!
function love.mousereleased(x, y, button, istouch)
  local currentState = stateControl:get()
  
  if currentState.mousereleased then
    currentState:mousereleased(x, y, button, istouch)
  end
end

-- Read the keyboard!
function love.keypressed(key)
  local currentState = stateControl:get()
  
  if currentState.keypressed then
    currentState:keypressed(key)
  end
end

function love.keyreleased(key)
  local currentState = stateControl:get()
  
  if currentState.keyreleased then
    currentState:keyreleased(key)
  end
end

-- check the windows focus
function love.focus(f)
  local currentState = stateControl:get()
  
  if currentState.focus then
    currentState:focus(f)
  end
end

-- click to exit
function love.quit()
  print("Thanks for playing! Come back soon!")
end


function setWindowProperties()
  setIcon()
  setTitle()
  setBackgound()
end

function setIcon()
  local icon = love.graphics.newImage("/assets/images/logo.png")
  love.window.setIcon(icon:getData())
end

function setTitle()
  love.window.setTitle("Capture the Flag")
end

function setBackgound()
  love.graphics.setBackgroundColor(255,255,255)
end
