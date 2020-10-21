PlayState = Class{__includes = BaseState}

function PlayState:init()
  self.paddle = Paddle()
  self.ball = Ball()
  self.paused = false
  self.live = false
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
    else
      self.ball.dx = -self.ball.dx
    end
  end
end

function PlayState:render()
  self.paddle:render()
  self.ball:render()
  if not self.paused then
    gSounds['music']:play()
  else
    gSounds['music']:pause()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('PAUSED', 0, VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH, 'center')
  end
end