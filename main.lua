--[[
  Game: Breakout clone
  Author: Fabun Games
  Notes: All code based on that presented by Colton Ogden in Harvard course GD50
--]]

require('src.Dependencies')

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
    ['paddle-hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
    ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
    ['wall-hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
    ['confirm'] = love.audio.newSource('sounds/confirm.wav', 'static'),
    ['select'] = love.audio.newSource('sounds/select.wav', 'static'),
    ['no-select'] = love.audio.newSource('sounds/no_select.wav', 'static'),
    ['brick-hit-1'] = love.audio.newSource('sounds/brick_hit_1.wav', 'static'),
    ['brick-hit-2'] = love.audio.newSource('sounds/brick_hit_2.wav', 'static'),
    ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
    ['victory'] = love.audio.newSource('sounds/victory.wav', 'static'),
    ['recover'] = love.audio.newSource('sounds/recover.wav', 'static'),
    ['high-score'] = love.audio.newSource('sounds/high_score.wav', 'static'),
    ['pause'] = love.audio.newSource('sounds/pause.wav', 'static'),
    ['music'] = love.audio.newSource('sounds/music.wav', 'static')
  }

  gQuads = {
    ['bricks'] = GenerateBricks(gTextures['main'], 32, 16, 21),
    ['paddles'] = GeneratePaddles(gTextures['main'])
  }

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizable = true
  })

  gStateMachine = StateMachine{
    ['start'] = function() return StartState() end,
    ['launch'] = function() return LaunchState() end,
    ['play'] = function() return PlayState() end,
    ['highscore'] = function() return HighScoreState() end,
    ['score'] = function() return ScoreState() end
  }
  gStateMachine:change('start')

  --[[
      We create a table here to store any keys pressed during game play. We do this because LOVE's default behavior
      won't let us test for input from within other functions.
  --]]
  love.keyboard.keysPressed = {}

  --[[
      love.resize is a default function that is called any time the window is resized. We take advantage of that
      and use it to make a call to the push library to adjust the window size.
  --]]
end

--[[
    love.update is another default function that is called continuously throughout game play. It receives 'dt'
    which stands for 'delta time' and is measured in seconds. We can use this value to keep our game play updates
    consistent across different platforms.
--]]
function love.update(dt)
  gStateMachine:update(dt)

  love.keyboard.keysPressed = {}

  function love.resize(w, h)
    push:resize(w, h)
  end

  --[[
      keypressed() is a default function called any time a key is pressed. We are utilizing it to add a custom
      exit option.
  --]]
  function love.keypressed(key)
    if key == 'escape' then
      love.event.quit()
    end
    love.keyboard.keysPressed[key] = true
  end
end

-- A global function defined outside of love.update we can call from anywhere.
function love.keyboard.wasPressed(key)
  if love.keyboard.keysPressed[key] then
    return true
  end
  return false
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