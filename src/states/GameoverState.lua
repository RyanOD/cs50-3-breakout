GameoverState = Class{__includes = BaseState}

function GameoverState:enter(params)
  self.score = params.score
  self.highScores = params.highScores
end

function GameoverState:update(dt)
  if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
    gStateMachine:change('start', {
      highScores = self.highScores
    })
  end
end

function GameoverState:render()
  love.graphics.setFont(gFonts['large'])
  love.graphics.printf('Game Over', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')
  
  love.graphics.setFont(gFonts['medium'])
  love.graphics.printf('Final score = ' .. self.score, 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
  love.graphics.printf('Press enter to play again', 0, VIRTUAL_HEIGHT / 2 + 20, VIRTUAL_WIDTH, 'center')
end