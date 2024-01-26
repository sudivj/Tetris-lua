require("src/shapeData")
require("src/scores")

function load_board()
    print_to_log("   > Loading game area")
    bool_to_number = {[true] = 1, [false] = 0}

    ROW_SUM = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

    EMPTYLINE = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

    AREA = {
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

    chunkHeight = 0
end

function get_chunk_height()
    local sum = 0
    for i = 1, HEIGHT do if ROW_SUM[i] > 0 then sum = sum + 1 end end

    return sum
end

function clear_line(line)
    AREA[line] = EMPTYLINE
    print_to_log("   > Line cleared: " .. line)
    print_to_log("   > Score: " .. SCORE)
    while line > 1 do
        AREA[line] = AREA[line - 1]
        line = line - 1
    end
end

function add_tetra(t)
    print_to_log("   > Block placed at x: " .. t.col .. " y: " .. t.row)
    for i = 1, CELLS do
        local cell = TETRAMINO[t.current][t.orientation][i]
        if t.col + cell[2] < 1 then GAMESTATE = false end
        AREA[t.row + cell[1]][t.col + cell[2]] = t.current
        print_to_log("    |- > Cell placed at x: " .. t.col + cell[2] .. " y: " .. t.row + cell[1])
    end

    get_sum_of_lines()
end

function draw_game_area()
   if GAMESTATE then
    chunkHeight = get_chunk_height()
    --love.graphics.print(ticks)
    for y = HEIGHT - chunkHeight + 1, HEIGHT do
        for x = 1, WIDTH do
            local tetra_type = AREA[y][x]
            if AREA[y][x] ~= 0 then
                love.graphics.draw(love.graphics.newImage(return_colour(
                                                              tetra_type)),
                                   (x - 1) * CELLSIZE, (y - 1) * CELLSIZE, 0, 1)
                --love.graphics.print(tetra_type, (x - 1) * CELLSIZE,
                --                  (y - 1) * CELLSIZE, 0, 0.5)
            end
        end
        -- love.graphics.print(ROW_SUM[y], (32 * 15), (y - 1) * CELLSIZE, 0, 0.5)
        if ROW_SUM[y] == 10 then
            clear_line(y)
            SCORE = SCORE + 1
            get_sum_of_lines()
        end
        check_game_state()
    end
   end
end

function draw_UI(t)
    -- Game area border
    love.graphics.rectangle("line", 0, 0, WIDTH * CELLSIZE, HEIGHT * CELLSIZE)

    -- Scores
    love.graphics.rectangle("line", WIDTH * CELLSIZE + 10, 0, 32 * 5, 32 * 5)

    love.graphics.print("TOP", WIDTH * CELLSIZE + 15, 0, 0, 1, 1)
    love.graphics.print("999999", WIDTH * CELLSIZE + 15, 32 * 1, 0, 1, 1)
    love.graphics.print("SCORE", WIDTH * CELLSIZE + 15, 32 * 2 + 20, 0, 1, 1)
    love.graphics.print(SCORE, WIDTH * CELLSIZE + 15, 32 * 3 + 20, 0, 1, 1)

    -- Display next tetra

    love.graphics.rectangle("line", WIDTH * CELLSIZE + 10, 32 * 6 + 20,
                            (CELLSIZE * 4) + 20, 32 * 5)
    love.graphics.print("NEXT", WIDTH * CELLSIZE + 15, 32 * 6 + 20, 0, 1, 1)
    drawNextTetra(t.next)
end

function drawNextTetra(next_tetra)
    local tetra_start = {1, 2, 2, 1, 2, 2, 2}
    local cell = {}
    for i = 1, CELLS do
        cell.cell = TETRAMINO[next_tetra][1][i]
        cell.color = love.graphics.newImage(return_colour(tetra.next))
        love.graphics.draw(cell.color, ((WIDTH + cell.cell[2]) * CELLSIZE) +
                               (20 * tetra_start[next_tetra]),
                           ((cell.cell[1]) * CELLSIZE) + (32 * 6 + 32 * 2), 0, 1)
    end
end

function get_sum_of_lines()
    for i = 1, HEIGHT do
        local sum = 0
        for j = 1, WIDTH do sum = sum + bool_to_number[(AREA[i][j] ~= 0)] end
        ROW_SUM[i] = sum
    end
end

function check_game_state()
    if ROW_SUM[1] > 0 and GAMESTATE then
        prev_hs = tonumber(get_highscore())
        if prev_hs < SCORE then
            set_highscore(SCORE)
        else
            write_score_to_file(SCORE)
        end
        SCORE = 0
        GAMESTATE = false
        print_to_log("   > Game over")
        print_to_log("=> Menu loaded")
    end
end

function round(num, idp) -- Rounding a number| Code from:- https://love2d.org/forums/memberlist.php?mode=viewprofile&u=103181
    local mult = 10 ^ (idp or 0)
    return math.floor(num * mult + 0.5) / mult
end
