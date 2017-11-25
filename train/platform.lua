Platform = {}
Platform.width = 32
Platform.height = 32

function Platform:Create(x, y, influence, influenceDist, influenceDecay)
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
