Person = {}
Person.image = "/assets/images/person.png"
Person.width = 32
Person.height = 32

function Person:Create(x, y, influence)
    local this =
    {
        x = x,
        y = y,
        influence = influence
    }

    function this:Move(direction)
      --TODO: MAKE IT WALK IN OTHER VELOCITY
      self.x = self.x + direction.x;
      self.y = self.y + direction.y;
    end

    return this
end
