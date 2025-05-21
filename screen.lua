local screen = {
  state = nil,
  times = { '09:37', nil, nil, nil },
  error = nil
}

function screen:setTimes(times)
  self.error = nil
  self.times = times
end

function screen:setError(error)
  self.error = error
end

function screen:load(state)
  self.state = state
end

function screen:update(dt)
end

function screen:draw()
  love.graphics.setLineWidth(2)
  love.graphics.rectangle("line", 8, 8, WIDTH - 16, HEIGHT / 2 - 12)

  if self.error == nil then
    for index = 1, 4 do
      local stringWidth = 5 * 8  -- 5 characters * 8 pixels per character
      local totalStringsWidth = 4 * stringWidth
      local remainingSpace = WIDTH - totalStringsWidth
      local gap = remainingSpace / 5
      local x = gap + (index - 1) * (stringWidth + gap)

      local time = self.times[index]
      love.graphics.print(time or '--:--', x, 08 * 7)
    end
  else
    love.graphics.print(self.error, 0, 0)
  end
end

return screen
