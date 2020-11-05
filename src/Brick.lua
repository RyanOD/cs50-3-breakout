Brick = Class{}

function Brick:init(numCols, col, row)
  self.width = 32
  self.height = 16
  self.x = (VIRTUAL_WIDTH - numCols * self.width) / 2 + (col - 1) * self.width
  self.y = row * self.height
  self.color = 0
  self.tier = 1
  self.inPlay = true
end

function Brick:hit()
  if self.tier > 0 then
    if self.color == 1 then
        self.tier = self.tier - 1
        self.color = 5
    else
        self.color = self.color - 1
    end
  else
    -- if we're in the first tier and the base color, remove brick from play
    if self.color == 1 then
        self.inPlay = false
    else
        self.color = self.color - 1
    end
  end
end

function Brick:render()
  if self.inPlay then
    love.graphics.draw(gTextures['main'], gQuads['bricks'][(1 + (self.color - 1) * 4) + self.tier], self.x, self.y)
  end
end