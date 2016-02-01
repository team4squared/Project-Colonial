function math.clamp(val, a, b)
  if val > math.max(a, b) then
    return math.max(a, b)
  elseif val < math.min(a, b) then
    return math.min(a, b)
  else
    return val
  end
end

function math.loop(val, a, b)
  if val > math.max(a, b) then
    return math.min(a, b)
  elseif val < math.min(a, b) then
    return math.max(a,b)
  else
    return val
  end
end

function math.btw(val, a, b)
  return val <= math.max(a, b) and val >= math.min(a, b)
end