Field = {}
Field.redImage = love.graphics.newImage("/assets/images/field-red.png")
Field.blueImage = love.graphics.newImage("/assets/images/field-blue.png")
Field.width = Field.redImage:getData():getWidth()
Field.height = Field.redImage:getData():getHeight()

function Field:create(x, y, team, image, posw, posh)
    local influence = 0 
    if team == 1 then
        influence = 1
    else
        influence = -1
    end

    local this =
    {
        x = x,
        y = y,
        team = team,
        image = image,
        posw = posw,
        posh = posh,
        influence = 1,
        influenceDist = 1,
        influenceDecay = 1
    }
    
    function this:draw()
        local scalex = this.posw / Field.width
        local scaley = this.posh / Field.height

        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(this.image, this.x, this.y, 0, scalex, scaley)
    end

    return this
end
