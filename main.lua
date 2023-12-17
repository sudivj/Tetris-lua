require("src/render")
require("src/gameArea")

WIDTH = 10
HEIGHT = 20

function love.load()
    FONT = love.graphics.setNewFont("fonts/Monocraft.otf", 32)
    FONT:setFilter("nearest", "nearest")

    game.load()
end

function love.update(dt)
    game.update(dt)
end

function love.draw()
    game.draw()
end

function love.keypressed(key,scancode)
    game.keypress(key)
end