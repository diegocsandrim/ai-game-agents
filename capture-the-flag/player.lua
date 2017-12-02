Player = {}
Player.redImage = love.graphics.newImage("/assets/images/player-red.png")
Player.blueImage = love.graphics.newImage("/assets/images/player-blue.png")
Player.width = Player.redImage:getData():getWidth()
Player.height = Player.redImage:getData():getHeight()

function Player:create(x, y, team, image, posw, posh, isBot)
    local influence = 0 
    if team == 1 then
        influence = 5
    else
        influence = -5
    end

    local this =
    {
        type = "player",
        x = x,
        y = y,
        team = team,
        image = image,
        posw = posw,
        posh = posh,
        isBot = isBot,
        influence = influence,
        influenceDist = 5,
        influenceDecay = 1,
        minStaticInfluence = 0
    }
    
    function this:draw()
        local scalex = this.posw / Player.width
        local scaley = this.posh / Player.height

        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(this.image, this.x - this.posw/2, this.y - this.posh/2, 0, scalex, scaley)
    end

    return this
end
