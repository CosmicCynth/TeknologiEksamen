local aktivitet = {}
function aktivitet.load()
    kbbaggrund = love.graphics.newImage("sprites/KommendeBegivenheder.png")

end

function aktivitet.draw()
    love.graphics.draw(kbbaggrund)
end


return aktivitet