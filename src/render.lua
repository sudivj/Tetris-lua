require("src/shapeData")
require("src/utils")

game = {}
tetra = {}
tetra.current = 0
tetra.orientation = 0
tetra.next = 0
tetra.row = 4
tetra.col = 4

bool_to_number = { [true]=1, [false]=0 }

function game.load()
    selectBlock()
end

function game.update(dt)

end

function game.draw()
    drawBorders()
    cell = {}
    for i = 1, CELLS do
        cell.cell = TETRAMINO[tetra.current][tetra.orientation][i]
        cell.color = love.graphics.newImage(CELLCOLOUR[tetra.current])
        love.graphics.draw(cell.color, (tetra.col + cell.cell[1]) * CELLSIZE, (tetra.row + cell.cell[2]) * CELLSIZE, 0, 1)
    end
    love.graphics.print(tickGame())
end

function game.keypress(key)
    if key == "up" then
        cycleOrientation()
    end
    if key == "c" then
        selectBlock()
    end
    if key == "escape" then
        love.event.quit()
    end
end

function cycleOrientation()
    tetra.orientation = tetra.orientation + 1
    if tetra.orientation > 4 then
        tetra.orientation = 1
    end
end

function selectBlock()
    tetra.current = love.math.random(#TETRAMINO)
    tetra.next = love.math.random(#TETRAMINO)
    tetra.orientation = 1
    tetra.row = 0
    tetra.col = 3
end



function round(num, idp) -- Rounding a number| Code from:- https://love2d.org/forums/memberlist.php?mode=viewprofile&u=103181
    local mult = 10 ^ (idp or 0)
    return math.floor(num * mult + 0.5) / mult
end