HighscoreState = Class{__includes = BaseState}

local highlighted = 2

function HighscoreState:enter(params)
  self.highScores = params.highScores
end

function HighscoreState:update(dt)
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
      gStateMachine:change('start', {
        highScores = self.highScores
      })
    end
  end
end

function HighscoreState:render()
  -- title text
  love.graphics.setFont(gFonts['large'])
  love.graphics.printf('High Scores', 0, VIRTUAL_HEIGHT / 2 - 100, VIRTUAL_WIDTH, 'center')
  love.graphics.setFont(gFonts['small'])

  for i = 1, 10, 1 do
    love.graphics.printf(self.highScores[i].name, VIRTUAL_WIDTH / 2 - 40, VIRTUAL_HEIGHT / 2 - 65 + i * 10, VIRTUAL_WIDTH, 'left')
    love.graphics.printf(self.highScores[i].score, VIRTUAL_WIDTH / 2 + 20, VIRTUAL_HEIGHT / 2 - 65 + i * 10, VIRTUAL_WIDTH, 'left')
  end

  love.graphics.setFont(gFonts['medium'])
  if highlighted == 1 then
    love.graphics.setColor(184/255, 255/255, 73/255)
  end
  love.graphics.printf('PLAY GAME', 0, VIRTUAL_HEIGHT / 2 + 60, VIRTUAL_WIDTH, 'center')

  love.graphics.setColor(1, 1, 1)

  if highlighted == 2 then
    love.graphics.setColor(184/255, 255/255, 73/255)
  end
  love.graphics.printf('BACK TO START', 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH, 'center')
end