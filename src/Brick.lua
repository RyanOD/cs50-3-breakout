Brick = Class{}

function Brick:init(x, y)
  self.width = 32
  self.height = 16
  self.x = x
  self.y = y
  self.pattern = pattern
  self.skip = skip
end

function Brick:render()
  love.graphics.draw(gTextures['main'], gQuads['bricks'][1], self.x, self.y)
end
--[[
if skip then brick position is starting position + 64
  0 = (1 - 1) * 64
  64 = (2 - 1) * 64
  128 = (3 - 1) * 64
  192 = (4 - 1) * 64

if not skip then brick poisiton is starting position + 32
  0 = (1 - 1) * 32
  32 = (2 - 1) * 32
  64 = (3 - 1) * 32
  96 = (4 - 1) * 32
--]]