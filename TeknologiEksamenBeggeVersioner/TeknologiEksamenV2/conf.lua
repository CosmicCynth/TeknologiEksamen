function love.conf(t)
    t.window.width = 400
    t.window.height = 800
    t.console = true

    t.window.title = "Phinder"
    t.window.icon = "sprites/icon.png"

    --Lag reduce
    t.modules.joystick = false
    t.modules.physics = false
end