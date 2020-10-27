BrickRow = Class{}

function BrickRow:init(numColumns)
  self.layout = math.random(3)
  self.pattern = math.random(2)
  self.bricks = buildRow(numColumns)
end

function buildRow()
  local row = {}
  for i = 1, numColumns do
    row[i] = Brick()
  end
  return row
end