
printer = {}

function printer:new(x, y)
  local p = {}
  p.x = x
  p.y = y
  p.lineSpace = 15
  p.maxLines = 10
  p.lines = 0
  p.lineList = {}
  
  function p:write(m)
    if self.lines < self.maxLines then
      table.insert(self.lineList, m)
    else
      table.remove(self.lineList, 1)
      table.insert(self.lineList, m)
    end
  end
  
  function p:draw()
    for i, m in pairs(self.lineList) do
      if i % 2 == 0 then
        love.graphics.setColor(255, 255, 0)
      else
        love.graphics.setColor(0, 255, 0)
      end
      love.graphics.print(m, self.x, self.y)
    end
  end
  
  return p
end