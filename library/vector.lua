function Vec2(x, y)
  local self = {}
  
  self.x = x
  self.y = y
  self.type = "vec2"
  
  self.magnitude = function()
    return math.sqrt(self.x*self.x+self.y*self.y)
  end
  
  self.distance = function(vec)
    return math.sqrt(math.pow(self.x-vec.x, 2)+math.pow(self.y-vec.y, 2))
  end
  
  self.multiply = function(a, b)
    return a.x*b.x+a.y*b.y
  end
  
  self.angle = function(other)
    local x, y = 0, 0
    if type(other) == "table" then
      x = other.x
      y = other.y
    end
    return math.atan2(self.y - y, self.x - x)
  end
  
  self.vecTo = function(angle, distance, vec)
    vec = vec or Vec2(0, 0)
    
    self.x = distance * math.cos(angle) + vec.x
    self.y = distance * math.sin(angle) + vec.y
  end
  
  self.param = function()
    return self.x, self.y
  end
  
  self.between = function(a, b)
    return math.btw(self.x, a.x, b.x) and math.btw(self.y, a.y, b.y)
  end
  
  return setmetatable(self, {
      __add = function(a, b)
        if type(a) == "number" then
          return Vec2(a + b.x, a + b.y)
        elseif type(b) == "number" then
          return Vec2(a.x + b, a.y + b)
        else
          return Vec2(a.x + b.x, a.y + b.y)
        end
      end,
      __sub = function(a, b)
        if type(a) == "number" then
          return Vec2(a - b.x, a - b.y)
        elseif type(b) == "number" then
          return Vec2(a.x - b, a.y - b)
        else
          return Vec2(a.x - b.x, a.y - b.y)
        end
      end,
      __mul = function(a, b)
        if type(a) == "number" then
          return Vec2(a * b.x, a * b.y)
        elseif type(b) == "number" then
          return Vec2(a.x * b, a.y * b)
        else
          return Vec2(a.x * b.x, a.y * b.y)
        end
      end,
      __div = function(a, b)
        if type(a) == "number" then
          return Vec2(a / b.x, a / b.y)
        elseif type(b) == "number" then
          return Vec2(a.x / b, a.y / b)
        else
          return Vec2(a.x / b.x, a.y / b.y)
        end
      end,
      __mod = function(a, b)
        if type(a) == "number" then
          return Vec2(a % b.x, a % b.y)
        elseif type(b) == "number" then
          return Vec2(a.x % b, a.y % b)
        else
          return Vec2(a.x % b.x, a.y % b.y)
        end
      end,
      __eq = function(a, b)
        if type(a) == "number" then
          return a == b.x and a == b.y
        elseif type(b) == "number" then
          return a.x == b and a.y == b
        else
          return a.x == b.x and a.y == b.y
        end
      end,
      __lt = function(a, b)
        if type(a) == "number" then
          return a < b.x and a < b.y
        elseif type(b) == "number" then
          return a.x < b and a.y < b
        else
          return a.x < b.x and a.y < b.y
        end
      end,
      __le = function(a, b)
        if type(a) == "number" then
          return a <= b.x and a <= b.y
        elseif type(b) == "number" then
          return a.x <= b and a.y <= b
        else
          return a.x <= b.x and a.y <= b.y
        end
      end,
      __concat = function(a, b)
        return tostring(a)..tostring(b)
      end,
      __tostring = function(a)
        return "<"..a.x..", "..a.y..">"
      end
    })
end