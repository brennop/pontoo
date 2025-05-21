local login = require "login"
local register = require "register"

local state = {
  currentState = login,
  screen = nil,
}

function state:set(newState)
  self.currentState = newState

  newState:load(state)
end

function state:get()
  return self.currentState
end

function state:login(username, password)
  if username == "abc" then
    self.screen:setError("deu ruim :(")
  else
    self:set(register)

    -- local times = { '09:37', '12:08', '12:48', nil }
    local times = { '09:37', nil, nil, nil }

    self.screen:setTimes(times)
  end
end

return state
