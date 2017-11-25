Stand = {}
Stand.width = 32
Stand.height = 32

function Stand:Create(x, y, influence, influenceDist, influenceDecay)
    local this =
    {
        x = x,
        y = y,
        influence = influence,
        influenceDist = influenceDist,
        influenceDecay = influenceDecay
    }
    return this
end
