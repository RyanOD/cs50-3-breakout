TitleState = Class{__includes = BaseState}

function TitleState:init()

end



function TitleState:update(dt)
  -- listen for keypressed
    -- if 'enter', change to serve state
    -- if 'space', change to highscore state
end

function TitleState:render()
-- title text
love.graphics.setFont(gFonts['large'])
love.graphics.printf('Breakout', 0, 100, VIRTUAL_WIDTH, 'center')

-- instructions for starting game
-- title music
end