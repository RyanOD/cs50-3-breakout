--[[
  Game: Breakout clone
  Author: Fabun Games
  Notes: All code based on that presented by Colton Ogden in Harvard course GD50
--]]

require('src.Dependencies')

require('Paddle')

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.window.setTitle('Breakout')

  -- Declare keysPressed as an empty table to store keys pressed by user
  love.keyboard.keysPressed = {}

  gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
  }
  love.graphics.setFont(gFonts['small'])

  gTextures = {
    ['background'] = love.graphics.newImage('graphics/background.png'),
    ['main'] = love.graphics.newImage('graphics/breakout.png'),
    ['arrows'] = love.graphics.newImage('graphics/arrows.png'),
    ['hearts'] = love.graphics.newImage('graphics/hearts.png'),
    ['particle'] = love.graphics.newImage('graphics/particle.png')
  }

  gSounds = {
    ['paddle-hit'] = love.audio.newSource('sounds/paddle_hit.wav'),
    ['score'] = love.audio.newSource('sounds/score.wav'),
    ['wall-hit'] = love.audio.newSource('sounds/wall_hit.wav'),
    ['confirm'] = love.audio.newSource('sounds/confirm.wav'),
    ['select'] = love.audio.newSource('sounds/select.wav'),
    ['no-select'] = love.audio.newSource('sounds/no_select.wav'),
    ['brick-hit-1'] = love.audio.newSource('sounds/brick_hit_1.wav'),
    ['brick-hit-2'] = love.audio.newSource('sounds/brick_hit_2.wav'),
    ['hurt'] = love.audio.newSource('sounds/hurt.wav'),
    ['victory'] = love.audio.newSource('sounds/victory.wav'),
    ['recover'] = love.audio.newSource('sounds/recover.wav'),
    ['high-score'] = love.audio.newSource('sounds/high_score.wav'),
    ['pause'] = love.audio.newSource('sounds/pause.wav'),
    ['music'] = love.audio.newSource('sounds/music.wav')
  }

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizable = true
  })

  gStateMachine = StateMachine{
    ['start'] = function() return TitleState() end,
    ['launch'] = function() return LaunchState() end,
    ['play'] = function() return PlayState() end,
    ['highscore'] = function() return HighScoreState() end,
    ['score'] = function() return ScoreState() end
  }
  gStateMachine:change('start')
end

function love.update(dt)
  -- The keypressed() function is a defined Event in Love. We are utilizing it to run our own exit option.
  --gStateMachine:update(dt)
  function love.keypressed(key)
    if key == 'escape' then
      love.event.quit()
    end
  end
end

function love.draw()
  push:apply('start')
    local backgroundWidth = gTextures['background']:getWidth()
    local backgroundHeight = gTextures['background']:getHeight()

    love.graphics.draw(gTextures['background'], 0, 0, 0, VIRTUAL_WIDTH/(backgroundWidth - 1), VIRTUAL_HEIGHT/(backgroundHeight - 1))

    gStateMachine:render()
  push:apply('end')
end

function love.render()
  love.graphics.printf('Breakout', 0, 100, VIRTUAL_WIDTH, 'center')
end

--[[
Classes
paddle
ball
bricks
--]]