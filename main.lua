--[[
  Game: Breakout clone
  Author: Fabun Games
  Notes: All code based on that presented by Colton Ogden in Harvard course GD50
--]]

push = require('push')
Class = require('class')

require('config')
require('Paddle')
require('StateMachine')
require('states/TitleState')

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

  gStateMachine = StateMachine{
    ['title'] = function() return TitleState() end,
    ['launch'] = function() return LaunchState() end,
    ['play'] = function() return PlayState() end,
    ['highscore'] = function() return HighScoreState() end,
    ['score'] = function() return ScoreState() end
  }
  --gStateMachine:change('title')

end

function love.update(dt)
  -- The keypressed() function is a defined Event in Love. We are utilizing it to run our own exit option.
  function love.keypressed(key)
    if key == 'escape' then
      love.event.quit()
    end
  end
end

function love.render()
  mesh = gradientMesh( 'vertical', {1, 0, 0}, {1, 1, 0})
  push:start()
    love.graphics.draw(mesh, 0, 0)
    --gStateMachine:render()
  push:finish()
end

--[[
Classes
paddle
ball
bricks
--]]