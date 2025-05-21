-- maybe have a global timer??
local Timer = require "lib.timer"

local initialX = 64

local register = {
  state = nil,
  handle = {
    x = initialX,
    y = (240 / 2 - 12) / 2,
    size = 16,
    dragging = false,
    dragOffsetX = 0,
    dragOffsetY = 0
  }
}

function register:load(state)
  self.state = state
  self.timer = Timer()
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
  my = my - HEIGHT / 2
  
  if love.mouse.isDown(1) then
    if self.handle.dragging then
      self.handle.x = mx - self.handle.dragOffsetX
    else
      if mx >= self.handle.x - self.handle.size and mx <= self.handle.x + self.handle.size and
         my >= self.handle.y - self.handle.size and my <= self.handle.y + self.handle.size then

        self.handle.dragging = true
        self.handle.dragOffsetX = mx - self.handle.x
      end
    end
  else
    -- if we fall here and still dragging, than this is the last frame of the drag
    if self.handle.dragging then
      self.timer:tween(1, self.handle, { x = initialX }, 'out-elastic')
    end

    self.handle.dragging = false
  end

  self.timer:update(dt)
end

function register:draw()
  -- Draw the handle
  if self.handle.dragging then
    -- Highlight when dragging
    love.graphics.setColor(1, 0.8, 0.2)
  else
    love.graphics.setColor(0.5, 0.5, 0.8)
  end

  love.graphics.circle("fill", self.handle.x, self.handle.y, self.handle.size)
end

return register

