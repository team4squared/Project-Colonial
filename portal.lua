
portal = entity:new({
    debug = {
      drawMode = "fill"
    },
    list = {}
})

function portal:new(x, y, w, h, d)
  local p = {}
  p.pos = Vec2(x, y)
  p.size = Vec2(w, h)
  p.dest = d or ""
  p.entered = false
  table.insert(self.list, p)
  return p
end

function portal:debugGen(num)
  self.list = {}
  for i = 1, num or 10 do
    w = math.random(50, 100)
    h = math.random(50, 100)
    
    self:new(math.random(0, love.graphics.getWidth() - w), math.random(0, love.graphics.getHeight() - h), w, h)
  end
end


function portal:update(dt)
  if keylist.r then
    portal:debugGen()
  end
  
  for i, p in pairs(self.list) do
    if player.pos.between(p.pos, p.pos + p.size) then
      p.entered = true
    else
      p.entered = false
    end
  end
end

function portal:draw()
  if self.debug.drawMode then
    for i, p in pairs(self.list) do
      if p.entered then
        love.graphics.setColor(0, 255, 0, 200)
      else
        love.graphics.setColor(255, 0, 0, 200)
      end
      love.graphics.rectangle("fill", p.pos.x, p.pos.y, p.size.x, p.size.y)
    end
  end
end