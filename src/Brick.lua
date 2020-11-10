Brick = Class{}

paletteColors = {
  -- blue
  [1] = {
      ['r'] = 99,
      ['g'] = 155,
      ['b'] = 255
  },
  -- green
  [2] = {
      ['r'] = 106,
      ['g'] = 190,
      ['b'] = 47
  },
  -- red
  [3] = {
      ['r'] = 217,
      ['g'] = 87,
      ['b'] = 99
  },
  -- purple
  [4] = {
      ['r'] = 215,
      ['g'] = 123,
      ['b'] = 186
  },
  -- gold
  [5] = {
      ['r'] = 251,
      ['g'] = 242,
      ['b'] = 54
  }
}

function Brick:init(numCols, col, row, color, tier)
  self.width = 32
  self.height = 16
  self.x = (VIRTUAL_WIDTH - numCols * self.width) / 2 + (col - 1) * self.width
  self.y = row * self.height
  self.inPlay = true
  self.color = color
  self.tier = tier

  self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 64)
  self.psystem:setParticleLifetime(0.5, 1)
  self.psystem:setLinearAcceleration(-15, 0, 15, 80)
  self.psystem:setEmissionArea('normal', 10, 10)
end

function Brick:hit()
  self.psystem:setColors(
    paletteColors[self.color].r / 255,
    paletteColors[self.color].g / 255,
    paletteColors[self.color].b / 255,
    55 * (self.tier + 1),
    paletteColors[self.color].r / 255,
    paletteColors[self.color].g / 255,
    paletteColors[self.color].b / 255,
    0
  )
  self.inPlay = false
  self.psystem:emit(64)
--[[
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
--]]
end

function Brick:update(dt)
  self.psystem:update(dt)
end

function Brick:render()
  if self.inPlay then
    love.graphics.draw(gTextures['main'], gQuads['bricks'][(1 + (self.color - 1) * 4) + self.tier], self.x, self.y)
  end
end

function Brick:renderParticles()
  love.graphics.draw(self.psystem, self.x + 16, self.y + 8)
end