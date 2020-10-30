Lives = Class{}

function Lives:init()
  self.width = 10
  self.height = 9
  self.x = 468
  self.y = 5
  self.hearts = TOTAL_LIVES
end

function Lives:render()
  local x = self.x

  for i = 1, self.hearts do
    love.graphics.draw(gTextures['main'], gQuads['hearts'][1], self.x + i * self.width, self.y)
    x = x + self.width
  end

  for i = 1, 3 - self.hearts do
    love.graphics.draw(gTextures['main'], gQuads['hearts'][2], x + i * self.width, self.y)
  end
end