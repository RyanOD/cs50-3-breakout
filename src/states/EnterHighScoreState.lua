EnterHighScoreState = Class{__includes = BaseState}

function EnterHighScoreState:enter(params)
  self.highScore = params.highScore
end

function EnterHighScoreState:render()
  love.graphics.setFont(gFonts['large'])
  love.graphics.printf('Enter high score!', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')
  
  love.graphics.setFont(gFonts['medium'])
  love.graphics.printf('Press enter to play again', 0, VIRTUAL_HEIGHT / 2 + 20, VIRTUAL_WIDTH, 'center')
end