Map = {}

function Map:create(index)
  local this =
  {    
    seats = {},
    walls = {},
    platforms = {},
    stands = {},
    index = index
  }

  function this:isTileOccupied(tile)
    local value = this.index[tile.x][tile.y]
    
    local flagHasPerson = 0x00000010
    local band = bit.band(value, flagHasPerson)

    local occupied = bit.band(value, flagHasPerson) == flagHasPerson
    return occupied
  end

  function this:notify(person, oldTile, newTile)
    if(oldTile ~= nil) then
      this.index[oldTile.x][oldTile.y] = this.index[oldTile.x][oldTile.y] - 16
    end
    
    this.index[newTile.x][newTile.y] = this.index[newTile.x][newTile.y] + 16
  end

  function this:print()
    for i, line in ipairs(index) do
      for j, item in ipairs(line) do
        io.write(item.."\t")
      end
      io.write("\n")
    end
    io.write("\n")
  end

  return this

end
