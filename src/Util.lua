function GenerateBrickQuads(atlas, tileWidth, tileHeight, total)
  local quadTable = {}
  local quadCounter = 1
  local horizCount = atlas:getWidth() / tileWidth

  for y = 0, math.floor(total / horizCount) do
    for x = 0, (horizCount - 1) do
      quadTable[quadCounter] = love.graphics.newQuad(x * tileWidth, y * tileHeight, tileWidth, tileHeight, atlas:getDimensions())
      if quadCounter == total then
        return quadTable
      end
      quadCounter = quadCounter + 1
    end
  end
end

function GeneratePaddleQuads(atlas)
  local quadTable = {}
  local quadCounter = 1
  local x = 0
  local y = 64

  for i = 0, 3 do
    quadTable[quadCounter] = love.graphics.newQuad(0, i * 32 + y, 32, 16, atlas:getDimensions())
    quadCounter = quadCounter + 1
    quadTable[quadCounter] = love.graphics.newQuad(32, i * 32 + y, 64, 16, atlas:getDimensions())
    quadCounter = quadCounter + 1
    quadTable[quadCounter] = love.graphics.newQuad(96, i * 32 + y, 96, 16, atlas:getDimensions())
    quadCounter = quadCounter + 1
    quadTable[quadCounter] = love.graphics.newQuad(0, i * 32 + y + 16, 128, 16, atlas:getDimensions())
    quadCounter = quadCounter + 1
  end

  return quadTable
end