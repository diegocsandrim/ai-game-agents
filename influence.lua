require("person")

Influence = {}

function Influence:Create(w, h, window_w, window_h, map)
    local this =
    {
        w = w,
        h = h,
        window_w = window_w,
        window_h = window_h,
        map = map,
        influenceMap = {}
    }

    function this:ClearInfluence()
        for x=1,w do
            this.influenceMap[x] = {}
            for y=1,h do
                this.influenceMap[x][y] = 0
            end
        end
    end

    function this:Print()
        for x, column in ipairs(this.influenceMap) do
            for y, cell in ipairs(column) do
                io.write(string.format("%.3f", cell))
                io.write(" ")
            end
            print()
        end
        print()
    end
    
    function this:GetObjectInfluence(obj, x, y, tile)
        local influence = 0
        local distance = math.sqrt((tile.x - x)^2 + (tile.y - y)^2)

        if(distance < obj.influenceDist) then            
            influence = (1 * obj.influence)/(distance + 1) ^ obj.influenceDecay
        else
            influence = 0
        end

        return influence
    end

    function this:UpdateInfluence(objects)
        for _, object in ipairs(objects) do
            local tile = this:GetTileFromPosition(object.x, object.y)
            local dist = object.influenceDist
                
            for x=tile.x-dist,tile.x+dist do
                for y=tile.y-dist,tile.y+dist do
                    if (x > 0 and x <= this.w and y > 0 and y <= this.h) then
                        local influence = this:GetObjectInfluence(object, x, y, tile)
                        
                        this.influenceMap[x][y] = this.influenceMap[x][y] + influence
                    end
                end
            end
        end
    end

    function this:UpdateV2(map)
        this:ClearInfluence()
        this:UpdateInfluence(map.people)
        this:UpdateInfluence(map.seats)
        this:UpdateInfluence(map.walls)
        this:UpdateInfluence(map.platforms)
        this:UpdateInfluence(map.stands)
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

    function this:GetDirection(person, map)
        local tile = this:GetTileFromPosition(person.x, person.y)
        
        local tilex = tile.x
        local tiley = tile.y

        local targetTile = {}
        targetTile.x = 0
        targetTile.y = 0
        local maxValue = -math.huge
        local currentTileInfluence = -math.huge
        
        for x=tilex-1,tilex+1 do
            for y=tiley-1,tiley+1 do
                if (x > 0 and x <= w and y > 0 and y <= h) then
                    
                    local cellValue = this.influenceMap[x][y]
                    
                    -- Remove my own influence from map!
                    local ownInfluence = this:GetObjectInfluence(person, x ,y, tile)
                    
                    local othersInfluence = cellValue - ownInfluence

                    if(tilex == x and tiley == y) then
                        currentTileInfluence = othersInfluence
                    end

                    if(othersInfluence > maxValue) then
                        maxValue = othersInfluence
                        targetTile.x = x
                        targetTile.y = y
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

        local occupied = this.map:isTileOccupied(targetTile)
        if occupied then
            vectorx = 0
            vectory = 0
        else
        end

        local targetPosition = this:GetPositionFromTile(targetTile.x, targetTile.y)
        
        -- print("from ("..person.x..","..person.y..") to ("..targetPosition.x..","..targetPosition.y..")")

        vectorx = (targetPosition.x-person.x)
        vectory = (targetPosition.y-person.y)
        
        norm = math.sqrt((vectorx)^2 + (vectory)^2)

        -- You don't need to get into the center of the incluence map, 7 px is enought
        if(norm < 7) then
            vectorx = 0
            vectory = 0
            norm = 0
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
