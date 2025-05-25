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
  self.client:exec("Wait(inputField)")
  self.client:exec('String("1")')
  self.client:exec('Enter()')

  -- TODO: validate non empty
  self.client:exec("Wait(inputField)")
  self.client:exec('String("' .. username .. '")')
  self.client:exec('String("' .. password .. '")')
  self.client:exec('Enter()')

  if username == "abc" then
    self.screen:setError("deu ruim :(")
  else
    self:set(register)
    self.client:exec("Wait(inputField)")

    local times = { nil, nil, nil, nil }

    self.screen:setTimes(times)
  end
end

function state:register()
  self.client:exec('String("x")')
  self.client:exec('PF(2)')
end

return state
