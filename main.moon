Vector = require 'vector'

draggables = {}

addDraggable = (pos, size) ->
  table.insert draggables, {:pos, :size, dragging: false}

love.load = ->
  addDraggable (Vector 100, 100), (Vector 80, 80)
  addDraggable (Vector 200, 200), (Vector 80, 80)

love.mousepressed = (mx, my) ->
  mouse = Vector mx, my
  for thing in *draggables
    with thing
      if .pos < mouse and mouse < .pos + .size
        .dragging = true
        break

love.mousereleased = ->
  for thing in *draggables
    thing.dragging = false

love.mousemoved = (x, y, dx, dy) ->
  for thing in *draggables
    if thing.dragging
      thing.pos += Vector dx, dy

love.draw = ->
  for {:pos, :size} in *draggables
    x, y = pos\unpack()
    w, h = size\unpack()
    love.graphics.rectangle 'fill', x, y, w, h
