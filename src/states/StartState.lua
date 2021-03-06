StartState = Class{__includes = BaseState}

local highlighted = 1

function StartState:enter(params)
  self.highScores = params.highScores
end

function StartState:update(dt)
  if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
    highlighted = highlighted == 1 and 2 or 1
    gSounds['paddle-hit']:play()
  end

  if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
    if highlighted == 1 then
      gStateMachine:change('serve', {
        paddle = Paddle(),
        ball = Ball(),
        bricks = BrickTable:createMap(1), --this doesn't need to be so complex...call a function that builds table of bricks.
        lives = Lives(),
        score = 0,
        level = 1,
        highScores = self.highScores
      })
    elseif highlighted == 2 then
      gStateMachine:change('highscore', {
        highScores = self.highScores
      })
    end
  end
end

function StartState:render()
  love.graphics.setFont(gFonts['large'])
  love.graphics.printf('Breakout', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')
  love.graphics.setFont(gFonts['medium'])

  if highlighted == 1 then
    love.graphics.setColor(184/255, 255/255, 73/255)
  end
  love.graphics.printf('START', 0, VIRTUAL_HEIGHT / 2 + 60, VIRTUAL_WIDTH, 'center')

  love.graphics.setColor(1, 1, 1)

  if highlighted == 2 then
    love.graphics.setColor(184/255, 255/255, 73/255)
  end
  
  love.graphics.printf('HIGH SCORES', 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH, 'center')
end