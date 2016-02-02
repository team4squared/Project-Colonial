
player = entity:new()

function player:init(x, y, r)
  self.pos = Vec2(x or 0, y or 0) --Position
  self.corner = {
    topLeft = Vec2(0, 0),
    bottomRight = Vec2(0, 0)
  }
  self.vel = Vec2(0, 0) --Velocity
  self.speed = 200
  self.rotation = r or 0 --Rotation
  self.size = Vec2(192, 192)
  self.canvas = love.graphics.newCanvas(self.width, self.height)
  self.image = love.graphics.newImage("images/temp_player.png")
end

function player:update(dt)
  if keylist.w then
    self.vel.y = -self.speed
  elseif keylist.s then
    self.vel.y = self.speed
  elseif not keylist.w and not keylist.s then
    self.vel.y = 0
  end
  if keylist.a then
    self.vel.x = -self.speed
  elseif keylist.d then
    self.vel.x = self.speed
  elseif not keylist.a and not keylist.d then
    self.vel.x = 0
  end
  
  self.pos = self.pos + self.vel * dt
  printr:write(self.pos.." "..self.corner.topLeft)
  
  
  if mouse.button[1] or keylist.tab then
    self.rotation = mouse.angle(self.pos)
  elseif self.vel ~= 0 then
    self.rotation = math.atan2(self.vel.y, self.vel.x)
  end
end

function player:draw()
  love.graphics.setCanvas(self.canvas)
    love.graphics.clear()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(self.image, self.size.x/2, self.size.y/2, math.pi/2, .5, .5, self.size.x/2, self.size.y/2)
  love.graphics.setCanvas()
  love.graphics.draw(self.canvas, self.pos.x, self.pos.y, self.rotation, 1, 1, self.size.x/2, self.size.y/2)
end