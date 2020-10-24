Brick = Class{}

function Brick:init(i, j, numColumns)
  self.width = 32
  self.height = 16
  self.x = (j - 1) * self.width + (VIRTUAL_WIDTH - numColumns * self.width) / 2
  self.y = 30 + i * self.height
  self.gap = 2
end

function Brick:hit()
  gSound['brick-hit-2']:play()
  self.inPlay = false
end

function Brick:render()
  love.graphics.draw(gTextures['main'], gQuads['bricks'][1], self.x, self.y)
end


--[[

playstate instantiates a BrickTable object

BrickTable class is a table of tables each with each k, j position holding a Brick object


PlayState() -- holds the main BrickTable object
 - BrickTable() -- builds the main BrickTable object by pulling in Brick() objects
  - Brick -- creats the visual bricks on the screen

--]]