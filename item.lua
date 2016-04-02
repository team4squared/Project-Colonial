Item = {name = "", stats = {}}

function Item:new(o, name, stats)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.name = name
  self.stats = stats or {}
  return o
end