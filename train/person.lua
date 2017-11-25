Person = {}
Person.width = 32
Person.height = 32
Person.image = love.graphics.newImage("/assets/images/person.png")
Person.playerImage = love.graphics.newImage("/assets/images/player.png")

function Person:Create(x, y, influence, minStaticInfluence, influenceDist, tiredThreshold, influenceDecay, player)
    local this =
    {
        x = x,
        y = y,
        influence = influence,
        minStaticInfluence = minStaticInfluence,
        influenceDist = influenceDist,
        tiredThreshold = tiredThreshold,
        influenceDecay = influenceDecay,
        tired = 0,
        player = player,
        observers = {}
    }

    function this:Move(direction, param, influence)
        
        if (direction.x == 0 and direction.y == 0) then
            -- not to walk
        elseif love.math.random() > 0.95 then
            -- fail to walk
        else
            local newX = this.x + direction.x * 3
            local newY = this.y + direction.y * 3

            local oldTile = Util.GetTileFromPosition(this.x, this.y, param)
            local newTile = Util.GetTileFromPosition(newX, newY, param)

            if (oldTile.x ~= newTile.x or oldTile.y ~= newTile.y) then
                this:notifyObservers(oldTile, newTile)
            end
            
            this.x = newX
            this.y = newY
            
            this.tired = this.tired + 1
        end

    end

    function this:draw()
        local image
        
        if(player) then
            image = Person.playerImage
        else
            image = Person.image
        end

        love.graphics.setColor(255,255,255,255)
        love.graphics.draw(image, this.x - Person.width/2, this.y - Person.height/2)
    end
    
    function this:register(observer)
        table.insert(this.observers, observer)
    end

    function this:notifyObservers(oldTile, newTile)
        for _,observer in ipairs(this.observers) do
            observer:notify(this, oldTile, newTile)
        end
    end

    return this
end
