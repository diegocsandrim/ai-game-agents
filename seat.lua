Seat = {}
Seat.width = 32
Seat.height = 32
Seat.image = love.graphics.newImage("/assets/images/seat.png")

function Seat:Create(x, y, influence, influenceDist, influenceDecay)
    local this =
    {
        x = x,
        y = y,
        influence = influence,
        occupied = false,
        influenceDist = influenceDist,
        influenceDecay = influenceDecay
    }

    function this:draw()
        love.graphics.setColor(0,9,88,255)
        love.graphics.draw(Seat.image, this.x - Seat.width/2, this.y - Seat.height/2)
    end
    
    return this
end
