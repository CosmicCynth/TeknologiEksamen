SUIT = require"libaries/suit"
map = require"map"
aktivitet = require"aktivitet"
input = {text = ""}

function love.load()
    --Universel
    SUIT.theme.color = {
        normal = {bg = {1,1,1},fg = {0.5,0.5,0.5}},
        hovered = {bg = {1,1,1},fg = {0,0,0}},
        active = {bg = {1,1,1},fg = {0,0,0}}
        --bg = (0-1) 1 = hvid, 0 = sort
    }

    scene = "map"
    bar = love.graphics.newImage("sprites/DownMenu.png")
    searchBar = love.graphics.newImage("sprites/searchbar.png")
    style1 = love.graphics.newImage("sprites/style1.png")
    style2 = love.graphics.newImage("sprites/style2.png")
    style3 = love.graphics.newImage("sprites/style3.png")
    opretIcon = love.graphics.newImage("sprites/opretICO.png")
    

    --Map
    map.load()
    --Aktiviteter
    aktivitet.load()
end

function love.mousepressed(x, y, button)
    if scene == "map" then
        map.mousepressed(x, y, button)
    end
end

function love.mousereleased(x, y, button)
    if scene == "map" then
        map.mousereleased(x, y, button)
    end
end

function love.mousemoved(x, y, dx, dy)
    if scene == "map" then
        map.mousemoved(x, y, dx, dy)
    end
end

function love.wheelmoved(x, y)
    if scene == "map" then
        map.wheelmoved(x, y)
    end
end

--SUIT (Vigtig!!!)
function love.textinput(t)
	-- forward text input to SUIT
	SUIT.textinput(t)
end

function love.keypressed(key)
	-- forward keypresses to SUIT
	SUIT.keypressed(key)
end

function love.textedited(text, start, length)
    -- for IME input
    SUIT.textedited(text, start, length)
end


function love.update(dt)
    if scene == "map" then
        
    end

    if SUIT.Button("Kommende begivenheder",300,710,100,100).hit then
        scene = "aktiviteter" 
    end

    if SUIT.Button("Navigere",0,720,100,100).hit then
        scene = "map"
    end

    if SUIT.Button("Opret",150,720,100,100).hit then
        scene = "opret"
    end

    if love.keyboard.isDown("return") then
        for key, point in pairs(map.points) do
            if input.text:lower() == point.navn:lower() then
                scene = "map"
                map.xPos = point.X
                map.yPos = point.Y
                map.zoom = point.Zoom
                input.text = "" 
                break 
            end
        end
    end

    SUIT.Input(input, 95,15,250,30)

    print("MouseX: "..love.mouse.getX().." MouseY: "..love.mouse.getY())
    print("X: "..map.xPos.." Y: "..map.yPos.." Zoom: "..map.zoom)
end

function love.draw()
    if scene == "map" then
        map.draw()
        love.graphics.draw(style1,map.xPos + 1270 * map.zoom,map.yPos + 920 * map.zoom,nil,map.zoom * 2,map.zoom * 2)
        love.graphics.draw(style2,map.xPos + 1550 * map.zoom,map.yPos + 1940 * map.zoom,nil,map.zoom * 2,map.zoom * 2)
        love.graphics.draw(style3,map.xPos + 1820 * map.zoom,map.yPos + 710 * map.zoom,nil,map.zoom * 2,map.zoom * 2)
    elseif scene == "aktiviteter" then
        aktivitet.draw()
    end
    love.graphics.draw(searchBar,30,0)
    love.graphics.draw(bar,0,695)
    SUIT.draw()
    love.graphics.draw(opretIcon,175,705,nil,0.85,0.85)
end
