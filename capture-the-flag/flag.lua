Flag = {}
Flag.redImage = love.graphics.newImage("/assets/images/flag-red.png")
Flag.blueImage = love.graphics.newImage("/assets/images/flag-blue.png")
Flag.width = Flag.redImage:getData():getWidth()
Flag.height = Flag.redImage:getData():getHeight()

function Flag:create(x, y, team, image, posw, posh)
    local this =
    {
        x = x,
        y = y,
        team = team,
        image = image,
        posw = posw,
        posh = posh
    }
    
    function this:draw()
        local scalex = this.posw / Flag.width
        local scaley = this.posh / Flag.height

        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(this.image, this.x, this.y, 0, scalex, scaley)
    end

    return this
end
