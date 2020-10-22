Brick = Class{}

function Brick:init(x, y)
  self.width = 32
  self.height = 16
  self.x = x + ((VIRTUAL_WIDTH - ROW_COUNT * self.width) / 2)
  self.y = y
  self.gap = 2
end

function Brick:hit()
  gSound['brick-hit-2']:play()
  self.inPlay = false
end

function Brick:render(k)
  love.graphics.draw(gTextures['main'], gQuads['bricks'][1], self.x, self.y)
end