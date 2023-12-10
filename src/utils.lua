function tickGame()
    ticks = round(love.timer.getFPS())
    -- love.timer.sleep(1)
    return ticks
end

function round(num, idp) -- Rounding a number| Code from:- https://love2d.org/forums/memberlist.php?mode=viewprofile&u=103181
    local mult = 10 ^ (idp or 0)
    return math.floor(num * mult + 0.5) / mult
end