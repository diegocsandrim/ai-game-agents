require("flag")
require("map")
require("influence")

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
  this.influence = Influence:Create(32, 18, love.graphics.getWidth(), love.graphics.getHeight(), this.map)
  this.state = {}
  this.state.debug = false
  
  function this:audioPlay()
    Match.song:setLooping(true)
    Match.song:play()
  end

  function this:register(observer)
    table.insert(this.observers, observer)
  end

  function this:update(dt)
    if this.map.captured == 0 then
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
      
          
          this.influence:update(this.map)
      
          -- for k,player in ipairs(this.map.players) do   
          -- end
      
          for i=2,#this.map.players do
            local player = this.map.players[i]
            local direction = this.influence:GetDirection(player, this.map)
            
            this.map:move(player, direction)   
          end
    end
  end

  function this:draw()
    if this.map.captured ~= 0 then

      love.graphics.setColor(0,0,0, 255)
      love.graphics.setNewFont(50)
      local textX = 0
      local textY = love.graphics.getHeight()*(3/10)
      
      love.graphics.printf("Team "..this.map.captured.." captured the flag!", textX, textY, love.graphics.getWidth(), "center")
    else

      local prop = love.graphics.getWidth() / Match.width
      
          love.graphics.setColor(255,255,255, 127)
          love.graphics.draw(Match.image, 0, 0, 0, prop, prop)
      
          this.map.draw()
      
      
            
          local minValue = -5
          local maxValue = 5         
          local proportion = 255 / (maxValue-minValue)
      
          if(this.state.debug) then
            for x, column in ipairs(this.influence.influenceMap) do
                for y, cell in ipairs(column) do
      
                    local value = this.influence.influenceMap[x][y]
                    local color = (value - minValue) * proportion
                    color = math.min(255, color)
                    color = math.max(0, color)
      
                    local position = this.influence:GetStartPositionFromTile(x, y)
                    local size = this.influence:GetTileSize()
                    love.graphics.setColor(color, color, color, 127)
                    love.graphics.rectangle("fill", position.x, position.y, size.w, size.h)
                end
            end
      
          end
    end

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
    if key == 'd' then
      this.state.debug = not this.state.debug
    end
  end

  this:audioPlay()
  
  return this
end
