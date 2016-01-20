function Debugger()
  local self = {}
  
  self.space = 10
  self.draws = true
  
  self.msgs = {}
  
  self.new = function(title, value, color)
    local d = {}
    
    d.title = title
    d.value = value or ""
    d.color = {r = 255, g = 255, b = 255}
    if type(color) == "table" then
      d.color.r = color[1] or color.r
      d.color.g = color[2] or color.g
      d.color.b = color[3] or color.b
    end
    
    table.insert(self.msgs, d)
    
    return d
  end
  
  self.update = function(d, value)
    for i, m in pairs(self.msgs) do
      if m == d then
        d.value = value
      end
    end
  end
  
  self.color = function(d, color)
    for i, m in pairs(self.msgs) do
      if m == d then
         if type(color) == "table" then
          d.color.r = color[1] or color.r
          d.color.g = color[2] or color.g
          d.color.b = color[3] or color.b
        end
      end
    end
  end
  
  self.draw = function(x, y)
    if draws then
      for i, d in pairs(self.msgs) do
        love.graphics.setColor(d.color.r, d.color.g, d.color.b)
        love.graphics.print(d.title..": "..d.value, x, y + (self.space * i))
      end
    end
  end
  
  self.toggle = function()
    self.draws = not self.draws
  end
  
  return self
end