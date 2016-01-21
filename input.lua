
input = {}
keylist = {}
mouse = Vec2(0, 0)

function input:init()
  mouse.clicked = Vec2(0, 0)
  mouse.released = Vec2(0, 0)
  mouse.button = {}
end

function input:draw()
  local dString = ""
  for i, v in pairs(keylist) do
    if v then
      dString = dString.."'"..i.."'; "
    end
  end
  love.graphics.setColor(255, 255, 255)
  love.graphics.print(dString, 5, love.graphics.getHeight() - 20)
  dString = ""
  for i, v in pairs(mouse.button) do
    if v then
      dString = dString.."'"..i.."'; "
    end
  end
  
  love.graphics.setColor(255, 255, 0)
  love.graphics.print(dString, 5, love.graphics.getHeight() - 35)
  
  dString = "M: "..mouse.x..", "..mouse.y.."; "
  dString = dString.." C: "..mouse.clicked.x..", "..mouse.clicked.y.."; "
  dString = dString.." R: "..mouse.released.x..", "..mouse.released.y.."; "
  
  love.graphics.setColor(0, 255, 255)
  love.graphics.print(dString, 5, love.graphics.getHeight() - 50)
end

function love.keypressed(key, scode)
  keylist[tostring(scode)] = true
end

function love.keyreleased(key, scode)
  keylist[tostring(scode)] = false
end

function love.mousepressed(x, y, button)
  mouse.clicked.x = x
  mouse.clicked.y = y
  mouse.button[button] = true
end

function love.mousereleased(x, y, button)
  mouse.released.x = x
  mouse.released.y = y
  mouse.button[button] = false
end