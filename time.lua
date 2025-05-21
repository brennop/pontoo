local time = {}

function time:toMinutes(asString)
  local hours = tonumber(asString:sub(1, 2))
  local minutes = tonumber(asString:sub(4, 5))
  return hours * 60 + minutes
end

return time
