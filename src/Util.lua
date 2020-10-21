function GenerateBrickQuads(atlas)
  local tileWidth = 32
  local tileHeight = 16
  local totalTiles = 21
  local quadTable = {}
  local quadCounter = 1
  local horizCount = atlas:getWidth() / tileWidth

  for y = 0, math.floor(totalTiles / horizCount) do
    for x = 0, (horizCount - 1) do
      quadTable[quadCounter] = love.graphics.newQuad(x * tileWidth, y * tileHeight, tileWidth, tileHeight, atlas:getDimensions())
      if quadCounter == totalTiles then
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

function GenerateBallQuads(atlas)
  local quadTable = {}
  local quadCounter = 1
  local x = 96
  local y = 48
  local width = 8
  local height = 8

  while quadCounter < 8 do
    for i = 0, 1 do
      for j = 0, 3 do
        quadTable[quadCounter] = love.graphics.newQuad(x + j * width, y + i * 8, width, height, atlas:getDimensions())
        quadCounter = quadCounter + 1
      end
    end
    return quadTable
  end
end