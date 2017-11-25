GameState = {}

function GameState:create(param)
  local state = {}
  
  state.debug = param.debug
  state.pause = false
  state.step = false
  state.velocity = param.velocity

  return state
end
