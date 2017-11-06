require("person")

Influence = {}

function Influence:Create(w, h, window_w, window_h)
    local this =
    {
        w = w,
        h = h,
        window_w = window_w,
        window_h = window_h,
        map = {}
    }
    
    for x=1,w do
      this.map[x] = {}
      for y=1,h do
        this.map[x][y] = 0
      end
    end


    function this:Print()
        for x, column in ipairs(this.map) do
            for y, cell in ipairs(column) do
                io.write(string.format("%.3f", cell))
                io.write(" ")
            end
            print()
        end
        print()
    end
    
    function this:GetObjectInfluence(obj, x, y)
        local tile = this:GetTileFromPosition(obj.x, obj.y)       

        local influence = 0
        local distance = math.sqrt((tile.x - x)^2 + (tile.y - y)^2)

        if(distance < obj.influenceDist) then            
            influence = (1 * obj.influence)/(distance + 1)
        else
            influence = 0
        end

        return influence
    end

    function this:Update(objects)
        for x, column in ipairs(this.map) do
            for y, cell in ipairs(column) do
                this.map[x][y] = 0
                        
                local position = this:GetPositionFromTile(x,y)

                local cellx = position.x
                local celly = position.y

                for i, person in ipairs(objects.people) do
                    local influence = this:GetObjectInfluence(person, x, y)
                    
                    this.map[x][y] = this.map[x][y] + influence
                end

                for i, seat in ipairs(objects.seats) do
                    local influence = 0
                    
                    influence = this:GetObjectInfluence(seat, x, y)
                                        
                    this.map[x][y] = this.map[x][y] + influence
                end                

                for i, wall in ipairs(objects.walls) do
                    local influence = 0
                    
                    influence = this:GetObjectInfluence(wall, x, y)
                    
                    this.map[x][y] = this.map[x][y] + influence
                end

                for i, platform in ipairs(objects.platforms) do
                    local influence = 0
                    
                    influence = this:GetObjectInfluence(platform, x, y)
                    
                    this.map[x][y] = this.map[x][y] + influence
                end
            end
        end
    end
    
    function this:GetTileSize(x, y)
        local tilew = window_w/w
        local tileh = window_h/h
        
        local size = {}
        size.w = tilew
        size.h = tileh

        return size
    end

    function this:GetPositionFromTile(x, y)
        local cellx = (x-1) * window_w/w + (window_w/w)/2
        local celly = (y-1) * window_h/h + (window_h/h)/2
        
        local position = {}
        position.x = math.floor(cellx)
        position.y = math.floor(celly)

        return position
    end
    
    function this:GetStartPositionFromTile(x, y)
        local cellx = (x-1) * window_w/w
        local celly = (y-1) * window_h/h
        
        local position = {}
        position.x = cellx
        position.y = celly

        return position
    end

    function this:GetTileFromPosition(x, y)
        local mapx = math.floor(this.w * x / this.window_w) + 1
        local mapy = math.floor(this.h * y / this.window_h) + 1

        local mapx = math.min(mapx, this.w)
        local mapy = math.min(mapy, this.h)

        local position = {}
        position.x = mapx
        position.y = mapy

        return position
    end

    function this:GetDirection(person)
        local tile = this:GetTileFromPosition(person.x, person.y)
        
        local tilex = tile.x
        local tiley = tile.y

        local targetx = 0
        local targety = 0
        local maxValue = -math.huge
        local currentTileInfluence = -math.huge
        
        for x=tilex-1,tilex+1 do
            for y=tiley-1,tiley+1 do
                if (x > 0 and x <= w and y > 0 and y <= h) then
                    
                    local cellValue = this.map[x][y]
                    
                    -- Remove my own influence from map!
                    local ownInfluence = this:GetObjectInfluence(person, x ,y)
                    
                    local othersInfluence = cellValue - ownInfluence

                    if(tilex == x and tiley == y) then
                        currentTileInfluence = othersInfluence
                    end

                    if(othersInfluence > maxValue) then
                        maxValue = othersInfluence
                        targetx = x
                        targety = y
                    end
                end
            end
        end

        -- prefer to stay where I am if the others cell influence is the same
        if(maxValue == currentTileInfluence) then
            targetx = tile.x
            targety = tile.y
        end
        
        -- do not move for so little benefits
        if (math.abs(maxValue) < person.minStaticInfluence) then
            maxValue = currentTileInfluence
            targetx = tile.x
            targety = tile.y
        end

        local targetPosition = this:GetPositionFromTile(targetx, targety)

        -- print("from ("..person.x..","..person.y..") to ("..targetPosition.x..","..targetPosition.y..")")

        vectorx = (targetPosition.x-person.x)
        vectory = (targetPosition.y-person.y)
        

        norm = math.sqrt((vectorx)^2 + (vectory)^2)

        -- TODO: this should not be static, it may have errors when window have different sizes
        if(norm < 2) then
            vectorx=0
            vectory=0
        end

        if (norm == 0) then
            versorx = 0
            versory = 0
        else
            versorx = vectorx/norm
            versory = vectory/norm
        end

        direction = {}
        direction.x = versorx;
        direction.y = versory;

        return direction
    end

    return this
end
