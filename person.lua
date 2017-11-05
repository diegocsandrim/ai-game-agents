Person = {}
Person.width = 32
Person.height = 32
Person.image = love.graphics.newImage("/assets/images/person.png")

function Person:Create(x, y, influence, minStaticInfluence)
    local this =
    {
        x = x,
        y = y,
        influence = influence,
        minStaticInfluence = minStaticInfluence
    }

    function this:Move(direction)
      --TODO: MAKE IT WALK IN OTHER VELOCITY
      self.x = self.x + direction.x;
      self.y = self.y + direction.y;
    end

    function this:draw()
        love.graphics.draw(Person.image, this.x - Person.width/2, this.y - Person.height/2)
    end
    
    return this
end
