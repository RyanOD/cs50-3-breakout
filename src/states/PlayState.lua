PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
  self.paddle = params.paddle
  self.ball = params.ball
  self.bricks = params.bricks
  self.paused = false 
  self.live = false
  self.score = params.score
  self.lives = params.lives
  self.level = params.level
  self.highScores = params.highScores
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

  if self.ball:collides(self.paddle) then
    gSounds['paddle-hit']:play()
    if self.ball.y + self.ball.diameter <= self.paddle.y then
      if self.paddle.movingLeft and self.ball.dx < 0 or self.paddle.movingRight and self.ball.dx > 0 then
        self.ball.dx = self.ball.dx * 1.3
      end
    end
    if self.ball.y + self.ball.radius > self.paddle.y then
      if self.ball.x + self.ball.radius < self.paddle.x + 0.5 * self.paddle.width then
        self.ball.x = self.paddle.x - self.ball.diameter
        if self.ball.dx > 0 then
          self.ball.dx = -self.ball.dx
        end
      elseif self.ball.x + self.ball.radius > self.paddle.x + 0.5 * self.paddle.width then
        self.ball.x = self.paddle.x + self.paddle.width
        if self.ball.dx < 0 then
          self.ball.dx = -self.ball.dx
        end
      end
    else
      self.ball.y = self.paddle.y - self.ball.diameter
      self.ball.dy = -self.ball.dy
    end
  end

  for k, brick in ipairs(self.bricks) do
    brick:update(dt)
    if brick.inPlay then
      if self.ball:collides(brick) then
        self.score = self.score + 10000
        gSounds['brick-hit-2']:play()

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
        brick:hit()
      end
    end

    if checkVictory(self.bricks) then
      gStateMachine:change('victory', {
        level = self.level,
        lives = self.lives,
        score = self.score,
        highScores = self.highScores
      })
    end
  end

  if self.ball.y + self.ball.diameter > VIRTUAL_HEIGHT then
    gSounds['hurt']:play()
    self.lives.hearts = self.lives.hearts - 1

    local scoreNum = 11

    if self.lives.hearts == 0 then
      for i = 10, 1, -1 do
        if self.score > tonumber(self.highScores[i].score) then
          scoreNum = i
        end
      end
    
      if scoreNum < 11 then
        gStateMachine:change('enterhighscore', {
        scoreNum = scoreNum,
        highScores = self.highScores
      })
      else
        gStateMachine:change('gameover', {
        score = self.score,
        highScores = self.highScores
      })
      end
    else
      gStateMachine:change('serve', {
        paddle = self.paddle,
        ball = Ball(),
        bricks = self.bricks,
        lives = self.lives,
        score = self.score,
        level = self.level,
        highScores = self.highScores
      })
    end
  end
end

function PlayState:render()
  self.paddle:render()
  self.ball:render()
  self.lives:render()

  for k, brick in pairs(self.bricks) do
    brick:render()
    brick:renderParticles()
  end

  if not self.paused and not TESTING then
    gSounds['music']:play()
  elseif not TESTING then
    gSounds['music']:pause()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('PAUSED', 0, VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH, 'center')
  end

  displayScore(self.score)
end

function checkVictory(bricks)
  for k, brick in pairs(bricks) do
    if brick.inPlay then
      return false
    end
  end
  return true
end