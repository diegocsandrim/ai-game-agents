require("splash")
require("menu")
require("match")

StateControl = {}

function StateControl:create(param)
  local this = {}
  

  function this:set(state)
    this.state = state
  end

  function this:get()
    return this.state
  end
  
  function this:notify(state)
    if state.name == "splash" then
      this.state = Menu:create()
      this.state:register(this)
    elseif state.name == "menu" then
      this.state = Match:create()
      this.state:register(this)
    else
      error("Unknown state: "..state.name)
    end
  end

  return this
end
