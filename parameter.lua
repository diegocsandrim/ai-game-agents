Parameter = {}

function Parameter:create()
  local param = {}
  
  param.debug = false

  param.influence = {}
  param.influence.size = {}
  param.influence.size.x = 30
  param.influence.size.y = 20

  param.person = {}
  param.person.quantity = 100
  param.person.influence = -9
  param.person.minStaticInfluence = 0
  param.person.influenceDist = 1

  param.seat = {}
  param.seat.influence = 5
  param.seat.influenceDist = 2

  param.wall = {}
  param.wall.influence = -999
  param.wall.influenceDist = 1
  
  param.platform = {}
  param.platform.influence = -50
  param.platform.influenceDist = 5
  
  return param
end
