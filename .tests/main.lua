function love.load()
    test = {
        {
            {1,1,1},
            {0,1,0},
            {0,1,0},
            {0,1,0}
        }
    }
end

function love.update(dt)
end

function love.draw()
    local num = #test[1][2]
    love.graphics.print(num)
    debug.getinfo( love.load )
end