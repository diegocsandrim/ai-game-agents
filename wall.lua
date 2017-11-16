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
        love.graphics.rectangle("fill", this.x, this.y, Wall.width, Wall.height)
    end
    
    return this
end
