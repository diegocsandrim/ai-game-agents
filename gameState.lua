GameState = {}

function GameState:create(param)
  local state = {}
  
  state.debug = param.debug
  state.pause = false
  state.step = false

  return state
end
