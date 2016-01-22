
player = entity:new()

function player:init(x, y, r)
  self.pos = Vec2(x or 0, y or 0) --Position
  self.vel = Vec2(0, 0) --Velocity
  self.rotation = r or 0 --Rotation
  self.width = 50
  self.height = 50
  self.canvas = love.graphics.newCanvas(self.width, self.height)
end

function player:update(dt)
  if keylist.w then
    self.vel.y = -100
  elseif keylist.s then
    self.vel.y = 100
  elseif not keylist.w and not keylist.s then
    self.vel.y = 0
  end
  if keylist.a then
    self.vel.x = -100
  elseif keylist.d then
    self.vel.x = 100
  elseif not keylist.a and not keylist.d then
    self.vel.x = 0
  end
  
  self.pos = self.pos + self.vel * dt
  self.rotation = mouse.angle(self.pos)
end

function player:draw()
  love.graphics.setCanvas(self.canvas)
    love.graphics.clear()
    love.graphics.setBlendMode("alpha")
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", 12.5, 12.5, 25, 25)
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", 25, 24, 25, 2)
    love.graphics.setColor(255, 255, 255)
  love.graphics.setCanvas()
  love.graphics.draw(self.canvas, self.pos.x, self.pos.y, self.rotation, 1, 1, self.width/2, self.height/2)
end