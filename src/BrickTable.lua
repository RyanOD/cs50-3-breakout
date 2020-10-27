BrickTable = Class{}

COLUMN_COUNTS = {9, 11, 13}
ROW_COUNTS = {4, 5}

function BrickTable:init()
  self.numColumns = COLUMN_COUNTS[math.random(3)]
  self.numRows = ROW_COUNTS[math.random(2)]
  self.table = self:buildTable()
end

function BrickTable:buildTable()
  local table = {}
  local skip = math.random() < 0.5
  local pattern1, pattern2 = math.random(0, 1), math.random(0, 1)
  local color1, color2 = 1 + 4 * math.random(3), 1 + 4 * math.random(3)
  for i=1, self.numRows do
    table[i] = {}
    local colorFlag = true
    if skip then
      for j=1, self.numColumns, 1 do
        if colorFlag then
          table[i][j] = Brick(i, j, self.numColumns, color1 + pattern1)
        else
          table[i][j] = Brick(i, j, self.numColumns, color2 + pattern2)
        end
        colorFlag = not colorFlag
      end
    else
      for j=1, self.numColumns, 2 do
        if colorFlag then
          table[i][j] = Brick(i, j, self.numColumns, color1 + pattern1)
        else
          table[i][j] = Brick(i, j, self.numColumns, color2 + pattern2)
        end
        colorFlag = not colorFlag
      end
    end
    skip = not skip
  end
  return table
end

--[[

LAYOUT
solid
skip odd
skip even

COLORS
solid
alternating

flag = random boolean
LOOP START
render bricks
flag = not flag
LOOP END

What we have
 - 21 bricks
 - 6 solid bricks
 - 5 sets of 3 striped bricks (total of 21)

What we want to do
 - create custom boards with a combination of solid bricks, striped bricks, and gaps

Switching variables
 - pseudo-random integer bricksWideCount (7, 9, 11, or 13)
 - random integer rowCount (3, 4, or 5)
 - bool brickStriped
  if striped then 2, 3, 4...6, 7, 8...10, 11, 12...14, 15, 16...18, 19, 20
 - random integer color (1, 2, 3, 4, or 5)
 - bool hasGaps
 - bool altColor

Determine the number of rows (rowCount)
Determine the number of bricks in the width of the table (bricksWideCount)
For each row
  - determine if gaps (hasGaps)
  - determine alternating ()

  1 2 3 4
--]]