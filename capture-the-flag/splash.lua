Splash = {}
Splash.image = love.graphics.newImage("/assets/images/splash.png")
Splash.width = Splash.image:getData():getWidth()
Splash.height = Splash.image:getData():getHeight()

function Splash:create()
  local this = {}
  
  this.name = "splash"
  this.isdone = false
  this.observers = {}
  this.totalTime = 1
  this.showTime = 0
  
  function this:register(observer)
    table.insert(this.observers, observer)
  end

  function this:update(dt)
    this.showTime = this.showTime + dt
    
    if not this.isdone and this.showTime > this.totalTime then
      this.isdone = true
      this:done()
    end
  end

  function this:draw()
    local prop = love.graphics.getWidth() / Splash.width

    local transparence = math.min(this.showTime + 1 / this.totalTime, 1) * 255
    
    love.graphics.setColor(255,255,255, transparence)
    love.graphics.draw(Splash.image, 0, 0, 0, prop, prop)
  end

  function this:done()
    this:notifyObservers()
  end
  
  function this:notifyObservers()
    for _,observer in ipairs(this.observers) do
        observer:notify(this)
    end
end

  return this
end
