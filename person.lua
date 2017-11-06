Person = {}
Person.width = 32
Person.height = 32
Person.image = love.graphics.newImage("/assets/images/person.png")

function Person:Create(x, y, influence, minStaticInfluence, influenceDist, tiredThreshold)
    local this =
    {
        x = x,
        y = y,
        influence = influence,
        minStaticInfluence = minStaticInfluence,
        influenceDist = influenceDist,
        tiredThreshold = tiredThreshold,
        tired = 0,
        resting = false
    }

    function this:Move(direction)
        if (this.resting or this.tired > tiredThreshold) then
            this.resting = true
            this.tired = this.tired / 2

            if (this.tired < 1) then
                this.resting = false
            end
        else
            if (direction.x == 0 and direction.y == 0) then
                this.resting = true
            else
                this.tired = this.tired + 1
                --TODO: MAKE IT WALK IN OTHER VELOCITY
                self.x = self.x + direction.x * 3;
                self.y = self.y + direction.y * 3;
            end
        end

    end

    function this:draw()
        love.graphics.draw(Person.image, this.x - Person.width/2, this.y - Person.height/2)
    end
    
    return this
end
