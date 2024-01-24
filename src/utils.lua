ticks = 0

function tickGame(gravity)
    ticks = ticks + 1
    --love.graphics.print(ticks, 0, 0, 0, 0.5, 0.5)
    if ticks > gravity then
        ticks = 0
        return 1
    else 
        return 0
    end
end

function round(num, idp) -- Rounding a number| Code from:- https://love2d.org/forums/memberlist.php?mode=viewprofile&u=103181
    local mult = 10 ^ (idp or 0)
    return math.floor(num * mult + 0.5) / mult
end