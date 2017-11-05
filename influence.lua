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

    function this:Update(objects)
        for x, column in ipairs(this.map) do
            for y, cell in ipairs(column) do
                this.map[x][y] = 0
                        
                local position = this:GetPositionFromTile(x,y)

                local cellx = position.x
                local celly = position.y

                for i, person in ipairs(objects.people) do
                    local distance = math.sqrt((person.x - cellx)^2 + (person.y - celly)^2)
                    local influence = (1 * person.influence)/(distance + 1)
                    this.map[x][y] = this.map[x][y] - influence
                end
            end
        end
        --this:Print()
        --exit()
    end
    
    function this:GetPositionFromTile(x, y)
        local cellx = (x-1) * window_w/w + (window_w/w)/2
        local celly = (y-1) * window_h/h + (window_h/h)/2
        
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

        local targetx = 0;
        local targety = 0;
        local maxValue = -math.huge;

        for x=tilex-1,tilex+1 do
            for y=tiley-1,tiley+1 do
                if (x > 0 and x <= w and y > 0 and y <= h) then
                    cellValue = this.map[x][y]
                    if(cellValue > maxValue) then
                        maxValue = cellValue
                        targetx = x
                        targety = y
                    end 
                end
            end
        end
        
        --print("i'm on ("..tilex..","..tiley..") going to ("..targetx..","..targety..")")
        
        local tilePosition = this:GetPositionFromTile(targetx, targety)

        vectorx = (tilePosition.x-person.x)
        vectory= (tilePosition.y-person.y)

        norm = math.sqrt((vectorx)^2 + (vectory)^2)
        
        versorx = vectorx/norm
        versory = vectory/norm

        direction = {}
        direction.x = versorx;
        direction.y = versory;


        return direction

    end

    return this
end
