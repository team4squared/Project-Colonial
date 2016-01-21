
entity = {
  list = {}
}

function entity:new(t)
  local e = t or {}
  
  e.index = #entity.list + 1
  
  table.insert(self.list, e)
  return e
end

function entity:update(dt)
  for i, e in pairs(self.list) do
    if e.update then
      e:update(dt)
    end
  end
end

function entity:draw(d)
  for i, e in pairs(self.list) do
    if e.draw then
      e:draw()
    end
  end
end
