Brick = Class{}

function Brick:init(i, j, numColumns, pattern)
  self.width = 32
  self.height = 16
  self.x = (j - 1) * self.width + (VIRTUAL_WIDTH - numColumns * self.width) / 2
  self.y = 30 + i * self.height
  self.pattern = pattern
end

function Brick:hit()
  gSound['brick-hit-2']:play()
  self.inPlay = false
end

function Brick:render()
  love.graphics.draw(gTextures['main'], gQuads['bricks'][self.pattern], self.x, self.y)
end