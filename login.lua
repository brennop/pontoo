local login = {
  state = nil,
  username = "",
  password = "",
  index = 0,
}

function login:load(state)
  self.state = state
end

function login:keypressed(key)
  if key == "tab" then
    self.index = (self.index + 1) % 2
  elseif key == "backspace" then
    self:setInput(function(value) return value:sub(1, #value - 1) end)
  elseif key == "return" then
    self.state:login(self.username, self.password)
  end
end

function login:textinput(text)
  self:setInput(function(value) return value .. text end)
end

function login:update(dt)
end

function login:draw()
  love.graphics.print(self.username, 8 * 16 + 4, 8 * 6)

  for i = 1, #self.password do
    love.graphics.print("*", 8 * 15 + i * 8, 8 * 8)
  end
end

-- private

function login:setInput(callback)
  if self.index == 0 then
    self.username = callback(self.username):sub(1, 10)
  elseif self.index == 1 then
    self.password = callback(self.password):sub(1, 10)
  end
end

return login
