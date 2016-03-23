--[[
  Some utility methods that might be usefull
]]--

--Clamp a value (val) between a min and max
-- val - the value to clamp
-- a - the first boundry
-- b - the second boundry
-- returns a if val is beyond that boundry or b if val is beyond that boundry, otherwise returns val
function math.clamp(val, a, b)
  if val > math.max(a, b) then
    return math.max(a, b)
  elseif val < math.min(a, b) then
    return math.min(a, b)
  else
    return val
  end
end

--Loop a value (val) around a min and max
-- val - the value to clamp
-- a - the first boundry
-- b - the second boundry
-- returns a if val is beyond the boundry b or b if val is beyond the boundry a, otherwise returns val
function math.loop(val, a, b)
  if val > math.max(a, b) then
    return math.min(a, b)
  elseif val < math.min(a, b) then
    return math.max(a,b)
  else
    return val
  end
end

--Returns true if the value is between the other two values
-- val - the value to check
-- a - boundry one
-- b - boundry two
function math.btw(val, a, b)
  return val <= math.max(a, b) and val >= math.min(a, b)
end