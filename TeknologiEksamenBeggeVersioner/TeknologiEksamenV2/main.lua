SUIT = require"libaries/suit"
map = require"map"
aktivitet = require"aktivitet"
opret = require"opret"
input = {text = ""}
input1 = {text = ""}
input2 = {text = ""}
input3 = {text = ""}
input4 = {text = ""}

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
    mapIcon = love.graphics.newImage("sprites/mapICO.png")
    KommendeIcon = love.graphics.newImage("sprites/KICON.png")
    

    --Map
    map.load()
    --Aktiviteter
    aktivitet.load()
    --Opret
    opret.load()

    blackdot = {}
    blackdot.x = 0
    blackdot.y = 0
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
        blackdot.x = 90
        blackdot.y = 710
    elseif scene == "opret" then
        blackdot.x = 240
        blackdot.y = 715
        --Titel
        SUIT.Input(input1, 40,184,300,45)
        --Emne
        SUIT.Input(input2, 40,298,300,45)
        --Adresse
        SUIT.Input(input3, 40, 425,300,45)
        --Tidspunkt 
        SUIT.Input(input4,40, 555,300,45)


        if SUIT.Button("Opret!",150,630,100,50).hit then
            scene = "map"
            input1.text = "" 
            input2.text = ""
            input3.text = ""
            input4.text = ""
        end
    elseif scene == "aktiviteter" then
        blackdot.x = 385
        blackdot.y = 710
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

    SUIT.Input(input, 95,15,230,30)

    --[[print("MouseX: "..love.mouse.getX().." MouseY: "..love.mouse.getY())
    print("X: "..map.xPos.." Y: "..map.yPos.." Zoom: "..map.zoom)--]]
end

function love.draw()
    if scene == "map" then
        map.draw()
        love.graphics.draw(style1,map.xPos + 1270 * map.zoom,map.yPos + 920 * map.zoom,nil,map.zoom * 2,map.zoom * 2)
        love.graphics.draw(style2,map.xPos + 1550 * map.zoom,map.yPos + 1940 * map.zoom,nil,map.zoom * 2,map.zoom * 2)
        love.graphics.draw(style3,map.xPos + 1820 * map.zoom,map.yPos + 710 * map.zoom,nil,map.zoom * 2,map.zoom * 2)
    elseif scene == "aktiviteter" then
        aktivitet.draw()
    elseif scene == "opret" then
        opret.draw()
    end
    love.graphics.draw(searchBar,30,0)
    love.graphics.draw(bar,0,695)
    SUIT.draw()
    love.graphics.draw(opretIcon,170,705,nil,0.2,0.2)
    love.graphics.draw(mapIcon, 0,695,nil,0.65,0.65)
    love.graphics.draw(KommendeIcon,320,703,nil,0.30,0.30)
    love.graphics.setColor(0,0,0)
    love.graphics.circle("fill",blackdot.x,blackdot.y,8)
    love.graphics.setColor(255,255,255)
end
