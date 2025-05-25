local COLORS = {
  idle = 0.8,
  hover = 0.4,
  active = 1.0,
}

local register = {
  state = nil,
  button = {
    size = 16,
    state = "idle",
    color = COLORS.idle,
    handle = nil
  }
}

function register:textinput(text) end

function register:load(state)
  self.state = state
  self.button.x = (WIDTH / 2 - 12)
  self.button.y = (HEIGHT / 2 - 12) / 2
end

function register:keypressed(key)
end

function register:update(dt)
  local lastState = self.button.state

  if register:isHover() then
    self.button.state = "hover"

    if love.mouse.isDown(1) then
      self.button.state = "active"
    end
  else
    self.button.state = "idle"
  end
  
  if self.button.state ~= lastState then
    if self.button.handle then timer.cancel(self.button.handle) end

    timer.tween(0.3, self.button, { color = COLORS[self.button.state] }, "in-out-cubic")
  end
end

function register:draw()
  love.graphics.setColor(self.button.color, self.button.color, self.button.color)

  love.graphics.circle("fill", self.button.x, self.button.y, self.button.size)
end

function register:isHover()
  local mx, my = love.mouse.getPosition()
  -- account for love.graphics.translate
  my = my - HEIGHT / 2

  return mx >= self.button.x - self.button.size and mx <= self.button.x + self.button.size and
     my >= self.button.y - self.button.size and my <= self.button.y + self.button.size
end

return register

