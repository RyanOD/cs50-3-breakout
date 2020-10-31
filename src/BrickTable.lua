BrickTable = Class{}

COLUMN_COUNTS = {9, 11, 13}
ROW_COUNTS = {4, 5}

function BrickTable:init()
  self.numColumns = COLUMN_COUNTS[math.random(3)]
  self.numRows = ROW_COUNTS[math.random(2)]
  self.pattern = self:selectPattern()
  self.table = self:buildTable()
end

function BrickTable:buildTable()
  local table = {}
  local colors = {self:selectColor(), self:selectColor()}
  for i=1, self.numRows do
    table[i] = {}
    local colorFlag = math.random(1, 2)
    for j=1, self.numColumns do
      table[i][j] = Brick(i, j, self.numColumns, colors[colorFlag] + self.pattern)
      colorFlag = 3 - colorFlag
    end
  end
  return table
end

function BrickTable:selectColor()
  return 1 + 4 * math.random(0, 4)
end

function BrickTable:selectPattern()
  return math.random(0, 3)
end