--require("lldebugger").start()

require("src/tetraminos/drawBlocks")
require("src/gameArea")

BLOCKSIZE = 64 / 2
WIDTH = 10
HEIGHT = 20

function love.load()
    tetras.func.load()
    gameArea.func.setupArea()

    delta = 0
end

function love.update(dt)
    tetras.func.update(dt)
end

function love.draw()
    tetras.func.draw()
    love.graphics.print(love.timer.getFPS(), 352, 0)
    love.graphics.print(love.timer.getTime(), 400, 0)
end

function love.keypressed(key,scancode)
    tetras.func.keypress(key)
end