Paddle = Class{}

function Paddle:init()
  self.image = gQuads['paddles'][11]
  self.width = 64
  self.height = 16
  self.x = VIRTUAL_WIDTH / 2
  self.y = VIRTUAL_HEIGHT - 50
  self.dx = PADDLE_SPEED
end

function Paddle:update(dt)
  --listen for left/right key and move paddle
  if love.keyboard.isDown('left') and self.x > 0 then
    self.x = self.x - self.dx * dt
  elseif love.keyboard.isDown('right') and self.x < VIRTUAL_WIDTH - self.width then
    self.x = self.x + self.dx * dt
  end
end

function Paddle:render()
  love.graphics.draw(gTextures['main'], self.image, self.x, self.y)
end