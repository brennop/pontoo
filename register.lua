local register = {
  state = nil,
}

function register:load(state)
  self.state = state
end

function register:keypressed(key)
end

function register:textinput(text)
end

function register:update(dt)
end

function register:draw()
end

return register

