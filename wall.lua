Wall = {}
Wall.width = 32
Wall.height = 32


function Wall:Create(x, y, influence, influenceDist, influenceDecay)
    local this =
    {
        x = x,
        y = y,
        influence = influence,
        influenceDist = influenceDist,
        influenceDecay = influenceDecay
    }

    function this:draw()
        love.graphics.setColor(209,5,42,255)
        love.graphics.rectangle("fill", this.x, this.y, Wall.width, Wall.height)
    end
    
    return this
end
