Lives = Class{}

function Lives:init()
  self.width = 10
  self.height = 9
  self.x = 468
  self.y = 5
  self.hearts = 3
end

function Lives:render()
  for i=1, self.hearts do
    love.graphics.draw(gTextures['main'], gQuads['hearts'][1], self.x + i * self.width, self.y)
  end
end