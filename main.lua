local state = require "state"
local screen = require "screen"
local client = require "client"

WIDTH = 320
HEIGHT = 240

local function cleanup()
  print "closing"
  client:close()
  print "closed"
end

function love.quit()
  cleanup()
end

function love.load()
  state:get():load(state)
  state.screen = screen
  state.client = client
  client:load()

  local font = love.graphics.newFont("font.ttf", 8)
  love.graphics.setFont(font)

  love.mouse.setVisible(false)
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
  love.graphics.setBlendMode "alpha"
  love.graphics.setBackgroundColor(0.96, 0.96, 0.96)
  love.graphics.setColor(0.1, 0.1, 0.1)

  love.graphics.setLineWidth(2)
  love.graphics.setColor(0.1, 0.1, 0.1)
  love.graphics.rectangle("line", 8, 8, WIDTH - 16, HEIGHT / 2 - 12)

  screen:draw()

  love.graphics.push()
  love.graphics.translate(0, HEIGHT / 2)

  love.graphics.setLineWidth(2)
  love.graphics.setColor(0.1, 0.1, 0.1)
  love.graphics.rectangle("line", 8, 4, WIDTH - 16, HEIGHT / 2 - 12)

  state:get():draw()

  love.graphics.pop()

  local x, y = love.mouse.getPosition() 

  love.graphics.setBlendMode "subtract"
  love.graphics.circle("fill", x, y, 16)
end

function love.update(dt)
  screen:update()

  state:get():update(dt)
end

