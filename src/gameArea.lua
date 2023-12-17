require("src/shapeData")
require("src/debug")

bool_to_number = { [true]=1, [false]=0 }

EMPTYLINE = {0,0,0,0,0,0,0,0,0,0}

AREA = {
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0}
}

chunkHeight = 0

function get_chunk_height()
    local sum = 0
    for i = 1, HEIGHT do
        local line = AREA[i]
        if get_sum_of_line(line) > 0 then
            sum = sum + 1
        end
    end

    return sum
end

function shift_chunk_down(line)
    for y = 1, line - 1 do
        AREA[y + 1] = AREA[y]
    end
end

function clear_line(line)
    if get_sum_of_line(AREA[line]) == 10 then
        AREA[line] = EMPTYLINE
        --shift_chunk_down(line)
    end
end

function check_lines()
end

function add_tetra(t)
    chunkHeight = get_chunk_height()

    for i = 1, CELLS do
        local cell = TETRAMINO[t.type][t.orientation][i]
        AREA[t.row + cell[1]][t.col + cell[2]] = t.type
    end

    chunkHeight = get_chunk_height()
end

function draw_game_area()
    for y = HEIGHT - chunkHeight + 1, HEIGHT do
        for x = 1, WIDTH do
            local tetra_type = AREA[y][x]
            if AREA[y][x] ~= 0 then
                love.graphics.draw(love.graphics.newImage(CELLCOLOUR[tetra_type]), (x - 1) * CELLSIZE, (y - 1) * CELLSIZE, 0, 1)
                love.graphics.print( tetra_type,  (x - 1) * CELLSIZE, (y - 1) * CELLSIZE, 0, 0.5)
            end
        end
        love.graphics.print(get_sum_of_line(AREA[y]), 0, (y - 1) * CELLSIZE, 0, 0.5)
    end
    clear_line()
end

function draw_UI(t)
    -- Game area border
    love.graphics.rectangle("line", 0, 0, WIDTH * CELLSIZE, HEIGHT * CELLSIZE)

    -- Scores
    love.graphics.rectangle("line", WIDTH * CELLSIZE + 10, 0, 32 * 5, 32 * 5)

    love.graphics.print("TOP", WIDTH * CELLSIZE + 15, 0, 0, 1, 1)
    love.graphics.print("999999", WIDTH * CELLSIZE + 15, 32 * 1, 0, 1, 1)
    love.graphics.print("SCORE", WIDTH * CELLSIZE + 15, 32 * 2 + 20, 0, 1, 1)
    love.graphics.print("999999", WIDTH * CELLSIZE + 15, 32 * 3 + 20, 0, 1, 1)

    -- Display next tetra

    love.graphics.rectangle("line", WIDTH * CELLSIZE + 10, 32 * 6 + 20, (CELLSIZE * 4) + 20, 32 * 5)
    love.graphics.print("NEXT", WIDTH * CELLSIZE + 15, 32 * 6 + 20, 0, 1, 1)
    drawNextTetra(t.next)
end

function drawNextTetra(next_tetra)
    local tetra_start = { 1, 2, 2, 1, 2, 2, 2}
    local cell = {}
    for i = 1, CELLS do
        cell.cell = TETRAMINO[next_tetra][1][i]
        cell.color = love.graphics.newImage(CELLCOLOUR[tetra.next])
        love.graphics.draw(cell.color, ((WIDTH + cell.cell[2]) * CELLSIZE) + (20 * tetra_start[next_tetra]), ((cell.cell[1]) * CELLSIZE) + (32 * 6 + 32 * 2), 0, 1)
    end
end

function get_sum_of_line(line)
    local sum = 0
    for i = 1, WIDTH do
        sum = sum + bool_to_number[line[i] ~= 0]
    end

    return sum
end


function round(num, idp) -- Rounding a number| Code from:- https://love2d.org/forums/memberlist.php?mode=viewprofile&u=103181
    local mult = 10 ^ (idp or 0)
    return math.floor(num * mult + 0.5) / mult
end