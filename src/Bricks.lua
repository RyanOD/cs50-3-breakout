Bricks = Class{}

COLUMN_COUNTS = {7, 9, 11, 13}
ROW_COUNTS = {3, 4, 5}

function Bricks:init()
  self.numColumns = COLUMN_COUNTS[math.random(4)]
  self.numRows = ROW_COUNTS[math.random(3)]
  self.row = self:buildBrickField(self.numRows, self.numColumns, self.row)
end

function Bricks:buildBrickField(numRows, numColumns, row)
  local row = self:insertTable()
  for i=1, numRows do
    row[i] = self:insertTable()
    for j=1, numColumns do
      row[i][j] = self:addBrick(i, j)
    end
  end
  return row
end

function Bricks:insertTable()
  return {}
end

function Bricks:addBrick(i, j)
  return Brick(i, j, self.numColumns)
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