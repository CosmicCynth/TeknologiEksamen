local map = {}

function map.load()
    map.image = love.graphics.newImage("sprites/map.png")
    map.xPos = 0
    map.yPos = 0
    map.zoom = 0.5

    map.dragging = false
    map.dragStartX = 0
    map.dragStartY = 0
    map.mapStartX = 0
    map.mapStartY = 0

    map.points = {}
    map.points.one = {navn = "Sebastians fest",X = -1260,Y = -744, Zoom = 1.1, style = 1}
    map.points.two = {navn = "Skov indvigelse",X = -1114,Y = -1133, Zoom = 0.8, style = 2}
    map.points.three = {navn = "udflugt",X = -1479,Y = -348, Zoom = 0.9, style = 3}
end

function map.mousepressed(x, y, button)
    if button == 1 then 
        map.dragging = true
        map.dragStartX = x
        map.dragStartY = y
        map.mapStartX = map.xPos
        map.mapStartY = map.yPos
    end
end

function map.mousereleased(x, y, button)
    if button == 1 then
        map.dragging = false
    end
end

function map.mousemoved(x, y, dx, dy)
    if map.dragging then
        map.xPos = map.mapStartX + (x - map.dragStartX)
        map.yPos = map.mapStartY + (y - map.dragStartY)
    end
end

function map.wheelmoved(x, y)
    local zoomSpeed = 0.1

    if y > 0 then
        map.zoom = map.zoom + zoomSpeed
    elseif y < 0 then
        map.zoom = map.zoom - zoomSpeed
    end

    map.zoom = math.max(0.1, math.min(map.zoom, 5))
end

function map.draw()
    love.graphics.draw(map.image, map.xPos, map.yPos, 0, map.zoom, map.zoom)
end

return map
