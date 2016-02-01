
printer = {}

function printer:new(x, y, lf)
  local p = {}
  p.x = x
  p.y = y
  p.lineSpace = 15
  p.maxLines = 5
  p.lines = 0
  p.lineLife = lf or 5
  p.lineList = {}
  
  function p:write(m)
    if self.lines < self.maxLines then
      table.insert(self.lineList, {msg = tostring(m), life = 0})
      self.lines = self.lines + 1
    else
      table.remove(self.lineList, 1)
      table.insert(self.lineList, {msg = tostring(m), life = 0})
    end
  end
  
  function p:update(dt)
    for i, m in pairs(self.lineList) do
      m.life = m.life + dt
      if m.life >= self.lineLife then
        table.remove(self.lineList, i)
        p.lines = p.lines - 1
      end
    end
  end
  
  function p:draw()
    for i, m in pairs(self.lineList) do
      if i % 2 == 0 then
        love.graphics.setColor(255, 255, 0)
      else
        love.graphics.setColor(0, 255, 0)
      end
      love.graphics.print(m.msg, self.x, self.y + (i - 1) * self.lineSpace)
    end
  end
  
  return p
end