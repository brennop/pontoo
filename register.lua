local initialX = 64

local register = {
  state = nil,
  handle = {
    size = 16,
    dragging = false,
    dragOffsetX = 0,
    dragOffsetY = 0
  }
}

function register:textinput(text) end

function register:load(state)
  self.state = state

  self.world = love.physics.newWorld()
  self.body = love.physics.newBody(self.world, initialX, (240 / 2 - 12) / 2, "dynamic")
  self.anchor = love.physics.newBody(self.world, initialX, (240 / 2 - 12) / 2, "static")
  self.joint = love.physics.newDistanceJoint(self.body, self.anchor, self.body:getX(), self.body:getY(), self.anchor:getX(), self.anchor:getY())

  self.joint:setFrequency(0.8)
  self.joint:setDampingRatio(1.0)
end

function register:keypressed(key)
  if key == "escape" then
    self.handle.dragging = false
  elseif key == "a" then
    self.joint:setFrequency(self.joint:getFrequency() + 0.1)
    print(self.joint:getFrequency())
  elseif key == "s" then
    self.joint:setFrequency(self.joint:getFrequency() - 0.1)
    print(self.joint:getFrequency())
  elseif key == "z" then
    self.joint:setDampingRatio(self.joint:getDampingRatio() + 0.1)
    print(self.joint:getDampingRatio())
  elseif key == "x" then
    self.joint:setDampingRatio(self.joint:getDampingRatio() - 0.1)
    print(self.joint:getDampingRatio())
  elseif key == "q" then
    self.body:setLinearDamping(self.body:getLinearDamping() + 0.1)
    print(self.body:getLinearDamping())
  elseif key == "w" then
    self.body:setLinearDamping(self.body:getLinearDamping() - 0.1)
    print(self.body:getLinearDamping())
  end

end

function register:update(dt)
  local mx, my = love.mouse.getPosition()
  my = my - HEIGHT / 2
  
  if love.mouse.isDown(1) then
    if self.handle.dragging then
      self.body:applyLinearImpulse(-self.body:getX() + mx - self.handle.dragOffsetX, 0)
      --self.body:setX(mx - self.handle.dragOffsetX, 0)
    else
      if mx >= self.body:getX() - self.handle.size and mx <= self.body:getX() + self.handle.size and
         my >= self.body:getY() - self.handle.size and my <= self.body:getY() + self.handle.size then

        self.handle.dragging = true
        self.handle.dragOffsetX = mx - self.body:getX()
      end
    end
  else
    self.handle.dragging = false
  end

  self.world:update(dt)
end

function register:draw()
  -- Draw the handle
  if self.handle.dragging then
    -- Highlight when dragging
    love.graphics.setColor(1, 0.8, 0.2)
  else
    love.graphics.setColor(0.5, 0.5, 0.8)
  end

  love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.handle.size)
end

return register

