require("src/render")
require("src/gameArea")

WIDTH = 10
HEIGHT = 20

function love.load()
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