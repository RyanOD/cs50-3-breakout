Ball = Class{}

function Ball:init()
  self.width = 8
  self.height = 8
  self.x = VIRTUAL_WIDTH / 2 - self.width / 2
  self.y = VIRTUAL_HEIGHT - 59
  self.skin = math.random(1, 7)
  self.moving = false
  self.dx = math.random(-280, 280)
  self.dy = 150
end

function Ball:update(dt)
  if self.moving then
    self.x = self.x + self.dx * dt
    self.y = self.y - self.dy * dt
  end

  if self.x < 0 then
    self.x = 0
    gSounds['wall-hit']:play()
    self.dx = -self.dx
  end

  if self.x + 8 > VIRTUAL_WIDTH then
    self.x = VIRTUAL_WIDTH - 8
    gSounds['wall-hit']:play()
    self.dx = -self.dx
  end
  
  if self.y < 0 then
    gSounds['wall-hit']:play()
    self.y = 0
    self.dy = -self.dy
  end
end

function Ball:render()
  love.graphics.draw(gTextures['main'], gQuads['balls'][self.skin], self.x, self.y)
end

function Ball:collides(target)
  if self.x + self.width < target.x or self.x > target.x + target.width then
    return false
  elseif self.y + self.height < target.y or self.y > target.y + target.height then
    return false
  end

  return true
end