BrickTable = Class{}

function BrickTable:createMap(level)
  local bricks = {}

  local highestColor = math.min(level % 5 + 3, 5)
  local highestTier = math.min(math.floor(level % 5), 3)

  local numRows = math.random(3, 5)
  local numCols = math.random(7, 13)
  numCols = numCols % 2 == 0 and (numCols + 1) or numCols

  local alternating = math.random(1, 2) == 1 and true or false
  local alternatingFlag = math.random(1, 2) == 1 and true or false

  local skip = math.random(1, 2) == 1 and true or false
  local skipFlag = math.random(1, 2) == 1 and true or false

  local color1 = math.random(1, highestColor)
  local color2 = math.random(1, highestColor)

  local tier1 = math.random(1, highestTier)
  local tier2 = math.random(1, highestTier)

  for row=1, numRows do
    for col=1, numCols do
      if skip and skipFlag then
        skipFlag = not skipFlag
        goto continue
      else
        skipFlag = not skipFlag
      end
      
      -- create Brick instance
      b = Brick(numCols, col, row)

      if alternating and alternatingFlag then
        b.color = color1
        b.tier = tier1
        alternatingFlag = not alternatingFlag
      elseif alternating and not alternatingFlag then
        b.color = color2
        b.tier = tier2
        alternatingFlag = not alternatingFlag
      else
        b.color = color1
        b.tier = tier1
      end

      table.insert(bricks, b)
      ::continue::
    end
  end

  return bricks
end