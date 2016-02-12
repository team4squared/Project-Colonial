
function love.load(args)
  require("library.printer")
  require("library.util")
  require("library.vector")
  require("entity")
  require("input")
  
  input:init()
  printr = printer:new(5, 5)
  printr:write("Init Printer")
end

function love.update(dt)
  mouse.x, mouse.y = love.mouse.getPosition()
  entity:update(dt)
end

function love.draw()
  entity:draw()
  input:draw()
end

function love.mousepressed(x, y, button)

end

function love.mousereleased(x, y, button)

end
