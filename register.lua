local register = {
  state = nil,
  handle = {
    x = 400,
    y = 300,
    width = 50,
    height = 50,
    dragging = false,
    dragOffsetX = 0,
    dragOffsetY = 0
  }
}

function register:load(state)
  self.state = state
end

function register:keypressed(key)
  if key == "escape" then
    self.handle.dragging = false
  end
end

function register:textinput(text)
end

function register:update(dt)
  local mx, my = love.mouse.getPosition()
  
  if love.mouse.isDown(1) then
    if self.handle.dragging then
      -- Update handle position based on mouse movement
      self.handle.x = mx - self.handle.dragOffsetX
      self.handle.y = my - self.handle.dragOffsetY
    else
      -- Check if mouse is over the handle
      if mx >= self.handle.x and mx <= self.handle.x + self.handle.width and
         my >= self.handle.y and my <= self.handle.y + self.handle.height then
        -- Start dragging
        self.handle.dragging = true
        self.handle.dragOffsetX = mx - self.handle.x
        self.handle.dragOffsetY = my - self.handle.y
      end
    end
  else
    -- Release drag when mouse button is released
    self.handle.dragging = false
  end
end

function register:draw()
  -- Draw the handle
  if self.handle.dragging then
    -- Highlight when dragging
    love.graphics.setColor(1, 0.8, 0.2)
  else
    love.graphics.setColor(0.5, 0.5, 0.8)
  end
  
  love.graphics.rectangle("fill", self.handle.x, self.handle.y, 
                          self.handle.width, self.handle.height)
  
  -- Reset color
  love.graphics.setColor(1, 1, 1)
  
  -- Draw handle label
  love.graphics.print("Drag me", self.handle.x + 5, self.handle.y + 15)
end

return register

