require("influence")

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

    function this:Update(objects)
        for x, column in ipairs(this.map) do
            for y, cell in ipairs(column) do
                cell = 0
                for i, person in ipairs(objects.people) do
                    cell = cell + math.sqrt((person.x - x)^2 + (person.y - y)^2) * person.influence
                end
            end
        end
    end
    
    function this:GetDirection(person)
        mapx = math.floor(person.x / this.window_w) + 1
        mapy = math.floor(person.y / this.window_h) + 1
        print("mapx: "..mapx.." mapy: "..mapy)
    end

    return this
end
