VictoryState = Class{__includes = BaseState}

function VictoryState:enter(params)
  self.level = params.level
  self.score = params.score
  self.lives = params.lives
end

function VictoryState:update(dt)
  self:render()

  if love.keyboard.wasPressed('escape') then
    love.event.quit()
  end

  if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    self.level = self.level + 1
    gStateMachine:change('serve', {
      paddle = Paddle(),
      ball = Ball(),
      bricks = BrickTable:createMap(self.level),
      lives = Lives(),
      score = 0,
      level = self.level
    })
  end
end

function VictoryState:render()
  love.graphics.setFont(gFonts['large'])
  love.graphics.printf('Victory!', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')
  
  love.graphics.setFont(gFonts['medium'])
  love.graphics.printf('You cleared level ' .. tostring(self.level), 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
  love.graphics.printf('Press ENTER to serve', 0, VIRTUAL_HEIGHT / 2 + 30, VIRTUAL_WIDTH, 'center')
end