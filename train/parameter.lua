Parameter = {}

function Parameter:create()
  local param = {}
  
  param.debug = false
  param.velocity = 1

  param.influence = {}
  param.influence.size = {}
  param.influence.size.x = 30
  param.influence.size.y = 20

  param.person = {}
  param.person.quantity = 300
  param.person.influence = -100
  param.person.minStaticInfluence = 0
  param.person.influenceDist = 10
  param.person.influenceDecay = 5

  param.seat = {}
  param.seat.influence = 10
  param.seat.influenceDist = 1
  param.seat.influenceDecay = 1

  param.wall = {}
  param.wall.influence = -999
  param.wall.influenceDist = 1
  param.wall.influenceDecay = 1
  
  param.platform = {}
  param.platform.influence = -50
  param.platform.influenceDist = 1
  param.platform.influenceDecay = 1

  param.stand = {}
  param.stand.influence = 1
  param.stand.influenceDist = 10
  param.stand.influenceDecay = 1
  
  return param
end
