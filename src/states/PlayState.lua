PlayState = Class{__includes = BaseState}

function PlayState:init()
  self.paddle = Paddle()
  self.ball = Ball()
  self.bricks = BrickTable()
  --for i = 1, ROW_COUNT do
    --self.bricks[i] = Brick((i - 1) * 32, 30)
  --end
  self.paused = false 
  self.live = false
  self.hearts = 3
end

function PlayState:update(dt)
  if love.keyboard.wasPressed('space') then
    gSounds['pause']:play()
    self.paused = not self.paused
  end

  if not self.paused then
    self.paddle:update(dt)
    self.ball:update(dt)
  end

  if love.keyboard.wasPressed('escape') then
    love.event.quit()
  end

  if love.keyboard.wasPressed('return') then
    self.ball.moving = true
  end

  if self.ball:collides(self.paddle) then
    gSounds['paddle-hit']:play()
    if self.ball.y > VIRTUAL_HEIGHT - 58 then
      self.ball.y = VIRTUAL_HEIGHT - 58
      self.ball.dy = -self.ball.dy
    end

    if self.ball.dx > 0 and self.ball.x + 0.5 * self.ball.width > self.paddle.x + 0.75 * self.paddle.width or
       self.ball.dx < 0 and self.ball.x + 0.5 * self.ball.width < self.paddle.x + 0.25 * self.paddle.width then
      self.ball.dx = self.ball.dx * 1.3
    end
  end

  for k, brickRow in ipairs(self.bricks.table) do
    for j, brick in ipairs(brickRow) do
      if self.ball:collides(brick) then
        gSounds['brick-hit-2']:play()
        if self.ball.x < brick.x and self.ball.dx > 0 then
          self.ball.x = brick.x - self.ball.width
          self.ball.dx = -self.ball.dx
        elseif self.ball.x + self.ball.width > brick.x + brick.width and self.ball.dx > 0 then
          self.ball.x = brick.x + brick.width + self.ball.width
          self.ball.dx = -self.ball.dx
        elseif self.ball.y < brick.y then
          self.ball.y = brick.y - 8
          self.ball.dy = -self.ball.dy
        else
          self.ball.y = brick.y + 16
          self.ball.dy = -self.ball.dy
        end
        table.remove(self.bricks.table[k], j)
      end
    end
  end
  collectgarbage("collect")
end

function PlayState:render()
  self.paddle:render()
  self.ball:render()

  for k, brickRow in pairs(self.bricks.table) do
    for j, brick in pairs(brickRow) do
      brick:render()
    end
  end

  if not self.paused then
    gSounds['music']:play()
  else
    gSounds['music']:pause()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('PAUSED', 0, VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH, 'center')
  end

  for k, brick in pairs(self.bricks) do
    love.graphics.print(self.ball.dx)
  end
  
  for i=0, self.hearts - 1 do
    love.graphics.draw(gTextures['main'], gQuads['hearts'][1], 476 + i * 11, 5)
  end
end