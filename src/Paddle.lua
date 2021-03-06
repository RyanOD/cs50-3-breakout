Paddle = Class{}

function Paddle:init()
  self.skin = math.random(1,4)
  self.size = 2
  self.width = self.size * 32
  self.height = 16
  self.x = VIRTUAL_WIDTH / 2 - self.width / 2
  self.y = VIRTUAL_HEIGHT - 50
  self.dx = PADDLE_SPEED
  self.movingLeft = false
  self.movingRight = false
end

function Paddle:update(dt)
  if love.keyboard.isDown('left') and self.x > 0 then
    self.movingLeft = true
    self.x = self.x - self.dx * dt
  elseif love.keyboard.isDown('right') and self.x < VIRTUAL_WIDTH - self.width then
    self.movingRight = true
    self.x = self.x + self.dx * dt
  else
    self.movingLeft = false
    self.movingRight = false
  end
end

function Paddle:render()
  love.graphics.draw(gTextures['main'], gQuads['paddles'][(self.skin * 4 + self.size) - 4], self.x, self.y)
end

function Paddle:reset()
  self.x = VIRTUAL_WIDTH / 2 - self.width / 2
end