local Vector = require('vector')
local draggables = { }
local addDraggable
addDraggable = function(pos, size)
  return table.insert(draggables, {
    pos = pos,
    size = size,
    dragging = false
  })
end
love.load = function()
  addDraggable((Vector(100, 100)), (Vector(80, 80)))
  return addDraggable((Vector(200, 200)), (Vector(80, 80)))
end
love.mousepressed = function(mx, my)
  local mouse = Vector(mx, my)
  for _index_0 = 1, #draggables do
    local thing = draggables[_index_0]
    do
      if thing.pos < mouse and mouse < thing.pos + thing.size then
        thing.dragging = true
        break
      end
    end
  end
end
love.mousereleased = function()
  for _index_0 = 1, #draggables do
    local thing = draggables[_index_0]
    thing.dragging = false
  end
end
love.mousemoved = function(x, y, dx, dy)
  for _index_0 = 1, #draggables do
    local thing = draggables[_index_0]
    if thing.dragging then
      thing.pos = thing.pos + Vector(dx, dy)
    end
  end
end
love.draw = function()
  for _index_0 = 1, #draggables do
    local _des_0 = draggables[_index_0]
    local pos, size
    pos, size = _des_0.pos, _des_0.size
    local x, y = pos:unpack()
    local w, h = size:unpack()
    love.graphics.rectangle('fill', x, y, w, h)
  end
end