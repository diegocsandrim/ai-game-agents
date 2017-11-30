require("flag")
require("map")

Match = {}
Match.image = love.graphics.newImage("/assets/images/match.png")
Match.width = Match.image:getData():getWidth()
Match.height = Match.image:getData():getHeight()
Match.song = love.audio.newSource("/assets/songs/match.mp3")

function Match:create()
  local this = {}
  
  this.name = "match"
  this.observers = {}
  this.totalTime = 0
  this.map = Map:create(32, 18)

  function this:audioPlay()
    Match.song:setLooping(true)
    Match.song:play()
  end

  function this:register(observer)
    table.insert(this.observers, observer)
  end

  function this:update(dt)
    this.totalTime = this.totalTime + dt

    
    local direction = {}
    direction.x = 0
    direction.y = 0

    if love.keyboard.isDown("up") then
      direction.y = -1
    end

    if love.keyboard.isDown("down") then
      direction.y = 1
    end

    if love.keyboard.isDown("left") then
      direction.x = -1
    end

    if love.keyboard.isDown("right") then
      direction.x = 1
    end

    if direction.x ~= 0 or direction.y ~= 0 then
      local player1 = this.map:getPlayer1()
      this.map:move(player1, direction)
    end
  end

  function this:draw()
    local prop = love.graphics.getWidth() / Match.width

    love.graphics.setColor(255,255,255, 127)
    love.graphics.draw(Match.image, 0, 0, 0, prop, prop)

    this.map.draw()
  end

  function this:done()
    this:notifyObservers()
    Match.song:stop()
  end
  
  function this:notifyObservers()
    for _,observer in ipairs(this.observers) do
        observer:notify(this)
    end
  end

  function love.keypressed(key)
    
  end

  this:audioPlay()
  
  return this
end
