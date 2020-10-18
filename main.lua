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

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizable = true
  })

  -- Declare keysPressed as an empty table to store keys pressed by user
  love.keyboard.keysPressed = {}

  gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
  }
  love.graphics.setFont(gFonts['small'])

  gTextures = {
    ['background'] = love.graphics.newImage('graphics/background.png')
  }

  gStateMachine = StateMachine{
    ['title'] = function() return TitleState() end,
    ['launch'] = function() return LaunchState() end,
    ['play'] = function() return PlayState() end,
    ['highscore'] = function() return HighScoreState() end,
    ['score'] = function() return ScoreState() end
  }
  gStateMachine:change('title')
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