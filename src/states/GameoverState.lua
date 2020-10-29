GameoverState = Class{__includes = BaseState}

function GameoverState:update(dt)
  if love.keyboard.wasPressed('escape') then
    love.event.quit()
  end

  if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
    gStateMachine:change('start')
  end
end

function GameoverState:render()
  love.graphics.setFont(gFonts['large'])
  love.graphics.printf('Game Over', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')
  
  love.graphics.setFont(gFonts['medium'])
  love.graphics.printf('Press enter to play again', 0, VIRTUAL_HEIGHT / 2 + 20, VIRTUAL_WIDTH, 'center')
end