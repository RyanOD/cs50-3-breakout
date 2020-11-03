BrickTable = Class{}

function BrickTable:createMap()
  local bricks = {}

  local numRows = math.random(1, 5)
  local numCols = math.random(7, 13)

  for y=1, numRows do
    for x=1, numCols do
      b = Brick((x - 1) * 32 + 8 + (13 - numCols) * 16, y * 16)
      table.insert(bricks, b)
    end
  end

  return bricks
end



--[[


COLUMN_COUNTS = {9, 11, 13}
ROW_COUNTS = {4, 5}

function BrickTable:init()
  self.numColumns = math.random(7, 13)
  self.numColumns % 2 == 0 and (numColumns + 1) or numColumns
    
  self.numRows = ROW_COUNTS[math.random(2)]
  self.pattern = self:selectPattern()
  self.table = self:buildTable()
end

function BrickTable:buildTable()
  local table = {}
  local colors = {self:selectColor(), self:selectColor()}
  local skip = math.random() < 0.5
  for i=1, self.numRows do
    table[i] = {}
    local colorFlag = math.random(1, 2)
    for j=1, self.numColumns do
      table[i][j] = Brick(i, j, self.numColumns, colors[colorFlag] + self.pattern, skip)
    end
    colorFlag = 3 - colorFlag
    skip = not skip
  return table
  end
end

function BrickTable:selectColor()
  return 1 + 4 * math.random(0, 4)
end

function BrickTable:selectPattern()
  return math.random(0, 3)
end

--]]