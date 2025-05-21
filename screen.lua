local screen = {
  state = nil,
  times = { '09:37', nil, nil, nil },
  error = nil
}

function screen:setTimes(times)
  self.error = nil
  self.times = times

  if #self.times == 1 then
    local asMinutes = toMinutes(self.times[1])

    local min = asMinutes + 60 * 2
    local max = asMinutes + 60 * 4

    self.times[2] = {
      toTime(min),
      toTime(max)
    }
  end
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
  if self.error == nil then
    for index = 1, 4 do
      local stringWidth = 5 * 8  -- 5 characters * 8 pixels per character
      local totalStringsWidth = 4 * stringWidth
      local remainingSpace = WIDTH - totalStringsWidth
      local gap = remainingSpace / 5
      local x = gap + (index - 1) * (stringWidth + gap)

      local time = self.times[index]

      if type(time) == "number" then
        love.graphics.setColor(0.1, 0.1, 0.1)
        love.graphics.print(time, x, 08 * 7)
      elseif type(time) == "table" then
        love.graphics.setColor(0.2, 0.4, 0.8)
        love.graphics.print(time[1], x, 08 * 7 - 6)
        love.graphics.print(time[2], x, 08 * 7 + 6)
      else
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.print('--:--', x, 08 * 7)
      end
    end
  else
    love.graphics.print(self.error, 0, 0)
  end
end

function toMinutes(asString)
  local hours = tonumber(asString:sub(1, 2))
  local minutes = tonumber(asString:sub(4, 5))
  return hours * 60 + minutes
end

function toTime(asMinutes)
  local hours = math.floor(asMinutes / 60)
  local minutes = asMinutes % 60
  return string.format("%02d:%02d", hours, minutes)
end


return screen
