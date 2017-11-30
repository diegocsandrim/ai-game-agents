require("flag")
require("field")
require("player")

Map = {}

function Map:create(width, height)
  local this = {}

  this.width = width
  this.height = height
  this.static = {}
  this.player1 = nil

  local posw = love.graphics.getWidth() / this.width
  local posh = love.graphics.getHeight() / this.height
  

  for i=1,width do
    this.static[i] = {}
    for j=1,height do
      local obj
      if i <= 3 and j >= 8 and j <= 12 then
        obj = Field:create((i-1) * posw, (j-1) * posh, 2, Field.blueImage, posw, posh)
      elseif i >= 30 and j >= 8 and j <= 12 then
        obj = Field:create((i-1) * posw, (j-1) * posh, 1, Field.redImage, posw, posh)
      elseif i <= width /2 then
        obj = Field:create((i-1) * posw, (j-1) * posh, 1, Field.redImage, posw, posh)
      else
        obj = Field:create((i-1) * posw, (j-1) * posh, 2, Field.blueImage, posw, posh)
      end

      this.static[i][j] = obj
    end
  end

  this.position = {}
  
  this.position[01] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[02] = {0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0}
  this.position[03] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[04] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[05] = {0,0,0,3,0,0,0,0,0,3,0,0,0,0,3,0,0,0}
  this.position[06] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[07] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[08] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[09] = {0,0,0,0,0,3,0,0,0,0,0,3,0,0,0,0,0,0}
  this.position[10] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[11] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[12] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[13] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[14] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[15] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[16] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[17] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[18] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[19] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[20] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[21] = {0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0}
  this.position[22] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[23] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[24] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[25] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[26] = {0,0,0,4,0,0,4,0,0,0,4,0,0,0,4,0,0,0}
  this.position[27] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[28] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[29] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[30] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  this.position[31] = {0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0}
  this.position[32] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  
  local scalex = this.width / table.getn(this.position)
  local scaley = this.height / table.getn(this.position[1])
  

  for i, column in ipairs(this.position) do
    for j, type in ipairs(column) do
      if(type == 1) then
        local obj = Flag:create((i-1) * scalex * posw, (j-1) * scaley * posh, 1, Flag.redImage, posw, posh)
        this.position[i][j] = obj
      elseif(type == 2) then
        local obj = Flag:create((i-1) * scalex * posw, (j-1) * scaley * posh, 2, Flag.blueImage, posw, posh)
        this.position[i][j] = obj
      elseif(type == 3) then
        local obj = Player:create((i-1) * scalex * posw, (j-1) * scaley * posh, 1, Player.redImage, posw, posh)
        this.position[i][j] = obj
      elseif(type == 4) then
        local obj = nil
        
        
        -- Only one player
        if this.player1 == nil then
          local isBot = false
          obj = Player:create((i-1) * scalex * posw, (j-1) * scaley * posh, 2, Player.blueImage, posw, posh, isBot)
          this.player1 = obj
        else
          local isBot = true
          obj = Player:create((i-1) * scalex * posw, (j-1) * scaley * posh, 2, Player.blueImage, posw, posh, isBot)
        end

        this.position[i][j] = obj
      else
        this.position[i][j] = {}
      end
    end
  end

  
  function this:draw()
    
    for i, column in ipairs(this.static) do
      for j, type in ipairs(column) do
        if type.draw then
          type:draw()
        end
      end
    end

    for i, column in ipairs(this.position) do
      for j, type in ipairs(column) do
        if type.draw then
          type:draw()
        end
      end
    end

    
  end

  function this:getPlayer1()
    return this.player1
  end

  function this:move(player, direction)
    local versor = {}
    local norm = math.sqrt((direction.x)^2 + (direction.y)^2)

    if norm == 0 then
      versor.x = 0
      versor.y = 0
    else
      versor.x = direction.x * 3 / norm
      versor.y = direction.y * 3 / norm
    end

    local oldLocation = {x= player.x; y= player.y}
    local newLocation = {x= player.x + versor.x; y= player.y + versor.y}

    if newLocation.x - player.posw/2 < 0 or newLocation.x > love.graphics.getWidth() - player.posw/2 then
      newLocation.x = oldLocation.x
    end

    if newLocation.y - player.posh/2 < 0 or newLocation.y > love.graphics.getHeight() - player.posh/2 then
      newLocation.y = oldLocation.y
    end

    local newTile = this:getTileFromPosition(newLocation)
    local insideTheTargetCell = this.position[newTile.x][newTile.y]
      
    if insideTheTargetCell ~= nil and insideTheTargetCell.type == 'player' and insideTheTargetCell ~= player then
      newLocation = oldLocation
    end
    
    player.x = newLocation.x
    player.y = newLocation.y
  end

  function this:getTileFromPosition(position)
    local xPixelPerTile = love.graphics.getWidth() / this.width
    local yPixelPerTile = love.graphics.getHeight() / this.height
    
    local xtile = math.floor(position.x / xPixelPerTile) + 1 --Lua uses one-based arrays
    local ytile = math.floor(position.y / yPixelPerTile) + 1 --Lua uses one-based arrays :)

    local tile = {x= xtile; y= ytile}
    
    return tile
  end

  return this
end
