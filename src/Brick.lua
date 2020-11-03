Brick = Class{}

function Brick:init(numCols, col, row, color, tier)
  self.width = 32
  self.height = 16
  self.x = (VIRTUAL_WIDTH - numCols * self.width) / 2 + (col - 1) * self.width
  self.y = row * self.height
  self.color = 1
  self.tier = 0
end

function Brick:render()
  love.graphics.draw(gTextures['main'], gQuads['bricks'][self.color], self.x, self.y)
end