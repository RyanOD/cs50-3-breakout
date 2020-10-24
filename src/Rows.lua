Rows = Class{}

COLUMN_COUNTS = {7, 9, 11, 13}
ROW_COUNTS = {3, 4, 5}

function Rows:init()
  self.row = {}
  self.numColumns = COLUMN_COUNTS[math.random(4)]
  self.numRows = ROW_COUNTS[math.random(3)]
  for i=1, self.numRows do
    self.row[i] = {}
    for j=1, self.numColumns do
      self.row[i][j] = Brick((j - 1) * 32, 30)
    end
  end
end


--[[
  
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