require("src/shapeData")


function drawBorders()
    love.graphics.rectangle("line", 0, 0, WIDTH * CELLSIZE, HEIGHT * CELLSIZE)
    --love.graphics.print(round(love.timer.getTime(), 3) * 1000)
end

function round(num, idp) -- Rounding a number| Code from:- https://love2d.org/forums/memberlist.php?mode=viewprofile&u=103181
    local mult = 10 ^ (idp or 0)
    return math.floor(num * mult + 0.5) / mult
end