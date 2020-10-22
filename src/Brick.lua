Brick = Class{}

function Brick:init(x, y)
  self.x = x
  self.y = y
  self.width = 32
  self.height = 16
  self.inPlay = true
end

function Brick:hit()
  gSound['brick-hit-2']:play()
  self.inPlay = false
end

function Brick:render()
  if self.inPlay then
    love.graphics.draw(gTextures['main'], gQuads['bricks'][1], self.x, self.y)
  end
end