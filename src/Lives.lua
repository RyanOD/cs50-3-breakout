Lives = Class{}

function Lives:init()
  self.width = 10
  self.height = 9
  self.x = 468
  self.y = 5
  self.hearts = {true, true, true}
end

function Lives:render()
  for i, heart in pairs(self.hearts) do
    if heart then
      love.graphics.draw(gTextures['main'], gQuads['hearts'][1], self.x + i * self.width, self.y)
    else
      love.graphics.draw(gTextures['main'], gQuads['hearts'][2], self.x + i * self.width, self.y)
    end
  end
end