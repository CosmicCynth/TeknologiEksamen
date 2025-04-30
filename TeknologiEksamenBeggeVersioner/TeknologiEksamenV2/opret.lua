opret = {}
function opret.load()
    opretBG = love.graphics.newImage("sprites/opret.png")
end


function opret.draw()
    love.graphics.draw(opretBG)
end

return opret