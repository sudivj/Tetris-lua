
--    This is just a little I wrote to debug my code in run-time.


tetris_debug = {}
screen = love.graphics

function tetris_debug.print_x_y(t)
    screen.print(t.col .. " : " .. t.row)
end

function tetris_debug.print(arg, x, y)
    screen.print(arg, x, y)
end