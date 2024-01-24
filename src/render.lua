require("src/shapeData")
require("src/gameArea")
require("src/utils")

game = {}
tetra = {}
tetra.next = love.math.random(#TETRAMINO) --Current tetra
tetra.gravity = 30
time = 0

function game.load()
    load_board()
    select_block()
end

function game.update(dt)
    check_wall_collision()
    if time < time + tickGame(tetra.gravity) then
        tetra_falling()
        time = time + 1
    end
    if love.keyboard.isDown("down") then
        tetra.gravity = 6
    else
        tetra.gravity = 30
    end
end

function game.draw()
    draw_UI(tetra)
    draw_tetra()
    draw_game_area(tetra.current)
end

function draw_tetra()
    local cell = {}
    for i = 1, CELLS do
        cell.cell = TETRAMINO[tetra.current][tetra.orientation][i]
        cell.color = love.graphics.newImage(return_colour(tetra.current))
        love.graphics.draw(cell.color, ((tetra.col - 1) + cell.cell[2]) * CELLSIZE, ((tetra.row - 1) + cell.cell[1]) * CELLSIZE, 0, 1)
    end
end

function game.keypress(key)
    if key == "up" then
        cycleOrientation()
    end
    if key == "escape" then
        love.event.quit()
    end
    if key == "right" and check_block_side_collision(tetra.orientation) then
        tetra.col = tetra.col + 1
    end
    if key == "left" and check_block_side_collision(tetra.orientation) then
        tetra.col = tetra.col - 1
    end
end

function cycleOrientation()
    if check_block_side_collision(next_orientation) and check_falling_tetra(next_orientation) then
        tetra.orientation = tetra.orientation + 1
        if tetra.orientation > 4 then
            tetra.orientation = 1
            next_orientation = ((tetra.orientation + 1) % 4) + 1
        end
        check_wall_collision()
    end
end

function select_block()
    tetra.prev = {}
    tetra.prev.row = tetra.row
    tetra.prev.col = tetra.col
    tetra.prev.type = tetra.current
    tetra.prev.orientation = tetra.orientation
    tetra.current = tetra.next
    tetra.next = love.math.random(#TETRAMINO)
    tetra.orientation = 1
    next_orientation = ((tetra.orientation + 1) % 4) + 1
    tetra.row = 1
    tetra.col = 4
end

function tetra_falling()
    if check_falling_tetra(tetra.orientation) == true then
        tetra.row = tetra.row + 1
    end
end

function check_falling_tetra(orientation)
    local cell = TETRAMINO[tetra.current][orientation][4]
    if (tetra.row) + (cell[1] + 1) > HEIGHT or check_block_collision() then
        select_block()
        add_tetra(tetra.prev)
        return false
    else
        return true
    end
end

function check_block_collision()
    local cell = TETRAMINO[tetra.current][tetra.orientation]
    local truth_table = {}
    truth_table[1] = AREA[(tetra.row + cell[1][1]) + 1][tetra.col + cell[1][2]] > 0
    truth_table[2] = AREA[(tetra.row + cell[2][1]) + 1][tetra.col + cell[2][2]] > 0
    truth_table[3] = AREA[(tetra.row + cell[3][1]) + 1][tetra.col + cell[3][2]] > 0
    truth_table[4] = AREA[(tetra.row + cell[4][1]) + 1][tetra.col + cell[4][2]] > 0
    return  (truth_table[1] or truth_table[2]) or (truth_table[3] or truth_table[4])
end

function check_wall_collision()
    if tetra.col + get_detail_tetra("s") < 1 then
        tetra.col = 1 - get_detail_tetra("s")
    elseif tetra.col + get_detail_tetra("w") > WIDTH then
        tetra.col = tetra.col - 1
    else
        return 1
    end
end

function check_block_side_collision(tetra_orientation)
    local cell = TETRAMINO[tetra.current][tetra_orientation]
    local truth_table = {}
    truth_table[1] = return_neighbour(1)
    truth_table[2] = return_neighbour(2)
    truth_table[3] = return_neighbour(3)
    truth_table[4] = return_neighbour(4)
    return ((truth_table[1] or truth_table[2]) or (truth_table[3] or truth_table[4])) == false
end

function return_neighbour(cell_x)
    local cell = TETRAMINO[tetra.current][tetra.orientation]
    local truth = AREA[tetra.row + cell[cell_x][1]][(tetra.col + cell[cell_x][2]) + 1] == nil or
                  AREA[tetra.row + cell[cell_x][1]][(tetra.col + cell[cell_x][2]) - 1] == nil
    if truth == true then
        return false
    else
        return AREA[tetra.row + cell[cell_x][1]][(tetra.col + cell[cell_x][2]) + 1] ~= 0 or
               AREA[tetra.row + cell[cell_x][1]][(tetra.col + cell[cell_x][2]) - 1] ~= 0
    end

end

function get_detail_tetra(dimention)
    local width_of_tetra = 0
    local start_of_tetra = CELLS

    for i = 1, CELLS do
        local cell = TETRAMINO[tetra.current][tetra.orientation][i]
        if width_of_tetra < cell[2] then
            width_of_tetra = cell[2]
        end
        if start_of_tetra > cell[2] then
            start_of_tetra = cell[2]
        end
    end

    if dimention == "s" then
        return start_of_tetra
    elseif dimention == "w" then
        return width_of_tetra
    end
end

function game.reset()
    load_board()
    SCORE = 0

    tetra.next = love.math.random(#TETRAMINO) --Current tetra
    tetra.gravity = 30
    time = 0

    select_block()
end



function round(num, idp) -- Rounding a number| Code from:- https://love2d.org/forums/memberlist.php?mode=viewprofile&u=103181
    local mult = 10 ^ (idp or 0)
    return math.floor(num * mult + 0.5) / mult
end