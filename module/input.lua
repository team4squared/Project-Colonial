local input = {}

local debugText = {
  x = 0,
  y = 0,
}

input.binding = {
  up = function() debugText.y = -1 end,
  left = function() debugText.x = -1 end,
  down = function() debugText.y = 1 end,
  right = function() debugText.x = 1 end,

  stopUp = function() if debugText.y == -1 then debugText.y = 0 end end,
  stopLeft = function() if debugText.x == -1 then debugText.x = 0 end end,
  stopDown = function() if debugText.y == 1 then debugText.y = 0 end end,
  stopRight = function() if debugText.x == 1 then debugText.x = 0 end end,

  quitGame = love.event.quit,
}

local keypressed = {
  w = "up",
  a = "left",
  s = "down",
  d = "right",
}

local keyreleased = {
  w = "stopUp",
  a = "stopLeft",
  s = "stopDown",
  d = "stopRight",

  escape = "quitGame",
}

function input.handler(_input)
  local action = input.binding[_input]
  if action then return action() end
end

function love.keypressed(_k)
  local binding = keypressed[_k]
  return input.handler(binding)
end

function love.keyreleased(_k)
  local binding = keyreleased[_k]
  return input.handler(binding)
end

function input.debugPrint()
  love.graphics.print("x axis: "..tostring(debugText.x).." y axis: "..tostring(debugText.y).." WASD ",0,love.graphics.getHeight()-14)
end

return input
