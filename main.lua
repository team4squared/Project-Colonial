
function love.load(args)
  require("library.printer")
  require("library.util")
  require("library.vector")
  require("entity")
  require("input")
  require("player")
  require("portal")
  
  printr = printer:new(5, 5)
  printr:write("Init Printer")
  
  input:init()
  player:init(love.graphics.getWidth()/2, love.graphics.getHeight()/2)
  portal:debugGen()
end

function love.update(dt)
  mouse.x, mouse.y = love.mouse.getPosition()
  entity:update(dt)
  printr:update(dt)
end

function love.draw()
  entity:draw()
  input:draw()
  printr:draw()
end

function love.mousepressed(x, y, button)

end

function love.mousereleased(x, y, button)

end
