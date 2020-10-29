ServeState = Class{__includes = BaseState}

function ServeState:enter(params)
  self.paddle = params.paddle
  self.paddle:reset()
  self.bricks = params.bricks
  self.ball = params.ball
  self.ball:reset()
  self.lives = params.lives
end

function ServeState:update(dt)
  if love.keyboard.wasPressed('escape') then
    love.event.quit()
  end

  self.paddle:update(dt)
  self.ball.x = self.paddle.x + 0.5 * self.paddle.width - 0.5 * self.ball.width

  if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
    gStateMachine:change('play', {
      paddle = self.paddle,
      bricks = self.bricks,
      ball = self.ball,
      lives = self.lives
    })
  end
end

function ServeState:render()
  self.paddle:render()
  self.ball:render()

  for k, brickRow in pairs(self.bricks.table) do
    for j, brick in pairs(brickRow) do
      brick:render()
    end
  end

  love.graphics.setFont(gFonts['medium'])
  love.graphics.printf('Press enter to start play', 0, VIRTUAL_HEIGHT / 2 + 20, VIRTUAL_WIDTH, 'center')
end