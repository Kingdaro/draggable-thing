local Vector = require 'hump.vector'

local draggables = {}

local function addDraggable(pos, size)
  table.insert(draggables, {
    pos = pos,
    size = size,
    dragging = false,
  })
end

function love.load()
  addDraggable(Vector(100, 100), Vector(80, 80))
  addDraggable(Vector(200, 200), Vector(80, 80))
end

function love.mousepressed(mx, my)
  local mouse = Vector(mx, my)
  for _, thing in ipairs(draggables) do
    if thing.pos < mouse and mouse < thing.pos + thing.size then
      thing.dragging = true
      break
    end
  end
end

function love.mousereleased()
  for _, thing in ipairs(draggables) do
    thing.dragging = false
  end
end

function love.mousemoved(x, y, dx, dy)
  for _, thing in ipairs(draggables) do
    if thing.dragging then
      thing.pos = thing.pos + Vector(dx, dy)
    end
  end
end

function love.draw()
  for _, thing in ipairs(draggables) do
    local x, y = thing.pos:unpack()
    local w, h = thing.size:unpack()
    love.graphics.rectangle('fill', x, y, w, h)
  end
end
