local state = require "state"
local screen = require "screen"

WIDTH = 320
HEIGHT = 240

function love.load()
  state:get():load(state)
  state.screen = screen

  local font = love.graphics.newFont("font.ttf", 8)
  love.graphics.setFont(font)
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end

  state:get():keypressed(key)
end

function love.textinput(text)
  state:get():textinput(text)
end

function love.draw()
  screen:draw()

  love.graphics.push()
  love.graphics.translate(0, HEIGHT / 2)

  love.graphics.setLineWidth(2)
  love.graphics.rectangle("line", 8, 4, WIDTH - 16, HEIGHT / 2 - 12)

  state:get():draw()

  love.graphics.pop()
end

function love.update(dt)
  screen:update()

  state:get():update(dt)
end
