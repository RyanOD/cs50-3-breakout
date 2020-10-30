PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
  self.paddle = params.paddle
  self.ball = params.ball
  self.bricks = params.bricks
  self.paused = false 
  self.live = false
  self.score = params.score
  self.lives = params.lives
end

function PlayState:update(dt)
  self.ball.moving = true

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

  if self.ball:collides(self.paddle) then
    gSounds['paddle-hit']:play()
    if self.ball.y + 0.5 * self.ball.diameter > self.paddle.y and self.ball.y + 0.5 * self.ball.diameter < self.paddle.y + self.paddle.height then
      self.ball.dx = -self.ball.dx
    else
    --[[
      if self.ball.y + 0.5 * self.ball.> VIRTUAL_HEIGHT - 58 then
      self.ball.y = VIRTUAL_HEIGHT - 58
    --]]
      self.ball.dy = -self.ball.dy
    --end
    end
    
    if self.ball.dx > 0 and self.ball.x + 0.5 * self.ball.diameter > self.paddle.x + 0.75 * self.paddle.width or
       self.ball.dx < 0 and self.ball.x + 0.5 * self.ball.diameter < self.paddle.x + 0.25 * self.paddle.width then
      self.ball.dx = self.ball.dx * 1.3
    end
  end

  for k, brickRow in ipairs(self.bricks.table) do
    for j, brick in ipairs(brickRow) do
      if self.ball:collides(brick) then
        self.score = self.score + 5
        gSounds['brick-hit-2']:play()
        --[[
        if self.ball.x < brick.x and self.ball.dx > 0 then
          self.ball.x = brick.x - self.ball.diameter
          self.ball.dx = -self.ball.dx
        elseif self.ball.x + self.ball.diameter > brick.x + brick.width and self.ball.dx > 0 then
          self.ball.x = brick.x + brick.width + self.ball.diameter
          self.ball.dx = -self.ball.dx
        elseif self.ball.y < brick.y then
          self.ball.y = brick.y - 8
          self.ball.dy = -self.ball.dy
        else
          self.ball.y = brick.y + 16
          self.ball.dy = -self.ball.dy
        end
        --]]
        table.remove(self.bricks.table[k], j)
      end
    end
  end

  if self.ball.y + self.ball.diameter > VIRTUAL_HEIGHT then
    gSounds['hurt']:play()
    self.lives.hearts = self.lives.hearts - 1

    if self.lives.hearts == 0 then
      gStateMachine:change('gameover', {
        score = self.score
      })
    else
      gStateMachine:change('serve', {
        paddle = self.paddle,
        ball = Ball(),
        bricks = self.bricks,
        lives = self.lives,
        score = self.score
      })
    end
  end

  collectgarbage('collect')
end

function PlayState:render()
  self.paddle:render()
  self.ball:render()
  self.lives:render()

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
end