require("src/tetraminos/shapeData")

gameArea = {}

gameArea.area = {}
gameArea.areaPrevious = {}
gameArea.func = {}

filledLines = {}
emptyLine = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

function gameArea.func.setupArea()
    gameArea.area = {
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
    }
    gameArea.areaPrevious = gameArea.area
end

function gameArea.func.drawArea()
    for y = 1, HEIGHT do
        local blocksFilled = 0
        for x = 1, WIDTH do
            if gameArea.area[y][x] ~= 0 then
                local sprite = love.graphics.newImage(blockColours[gameArea.area[y][x] + 1])
                love.graphics.draw(sprite, ((x - 1) * BLOCKSIZE), ((y - 1) * BLOCKSIZE), 0, 0.5)
                blocksFilled = blocksFilled + 1
            end
            love.graphics.print(gameArea.area[y][x], ((x - 1) * BLOCKSIZE), ((y - 1) * BLOCKSIZE))
        end
    end
end

function gameArea.func.removeLine(y)
    local lineTmp = y - 1

    gameArea.area[y] = emptyLine

    while lineTmp > 0 do
        gameArea.area[lineTmp + 1] = gameArea.area[lineTmp]
        lineTmp = lineTmp - 1
    end
end

function gameArea.func.checkBlock(posX, posY)
    return gameArea.area[posY][posX]
end
