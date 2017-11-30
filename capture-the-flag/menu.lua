Menu = {}
Menu.image = love.graphics.newImage("/assets/images/menu.png")
Menu.width = Menu.image:getData():getWidth()
Menu.height = Menu.image:getData():getHeight()
Menu.song = love.audio.newSource("/assets/songs/menu.mp3")

function Menu:create()
  local this = {}
  
  this.name = "menu"
  this.observers = {}
  this.totalTime = 0

  function this:audioPlay()
    Menu.song:setLooping(true)
    Menu.song:play()
  end

  function this:register(observer)
    table.insert(this.observers, observer)
  end

  function this:update(dt)
    this.totalTime = this.totalTime + dt
  end

  function this:draw()
    local prop = love.graphics.getWidth() / Menu.width

    love.graphics.setColor(255,255,255, 255)
    love.graphics.draw(Menu.image, 0, 0, 0, prop, prop)

    if math.floor(this.totalTime % 2) == 1 then
      love.graphics.setColor(255,0,0, 255)
      love.graphics.setNewFont(32)
      local textX = 0
      local textY = love.graphics.getHeight()*(6/10)
  
      love.graphics.printf("press enter to start", textX, textY, love.graphics.getWidth(), "center")
    end

  end

  function this:done()
    this:notifyObservers()
    Menu.song:stop()
  end
  
  function this:notifyObservers()
    for _,observer in ipairs(this.observers) do
        observer:notify(this)
    end
  end

  function love.keypressed(key)
    if key == "return" then
      this:done()
    end
  end

  this:audioPlay()
  
  return this
end
