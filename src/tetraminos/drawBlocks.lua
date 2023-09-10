require("src/tetraminos/shapeData")

tetras = {}
tetras.func = {}

-- Load --

function tetras.func.load()
    block, Orientation = tetras.func.selectBlock()
    blockSprite = love.graphics.newImage(blockColours[block + 1])

    blockPositionX = 4
    blockPositionY = 1

    blockWidth = shapeDimensionsDetails[block][Orientation][1]
    blockHeight = shapeDimensionsDetails[block][Orientation][2]

    gravity = 1

    delta = 1
    deltaTmp = 1
    
    isFalling = true
end

-- Update

function tetras.func.update(dt)

    tetras.func.blockXCollision()

    tetras.func.fall(love.keyboard.isDown("down"), dt)

end

-- Draw Blocks --

function tetras.func.draw()

    for y = 0, blockHeight - 1 do
        for x = 0, blockWidth - 1 do
            if shapeData[block][Orientation][y + 1][x + 1] == 1 then
                love.graphics.draw(blockSprite, (blockPositionX + x - 1) * BLOCKSIZE, (blockPositionY + y - 1) * BLOCKSIZE, 0, 0.5)                
            end
        end
    end

    gameArea.func.drawArea()

    -- For Debugging purposes --

    love.graphics.print(blockPositionX, 320, 0)
    love.graphics.print(blockPositionY, 320, 32)
    love.graphics.print(delta, 320, 64)
end

-- Pick Random Block --

function tetras.func.selectBlock()

    block = love.math.random(#shapeData)
    Orientation = 1

    blockPositionY = 1
    blockPositionX = 4

    blockWidth = shapeDimensionsDetails[block][Orientation][1]
    blockHeight = shapeDimensionsDetails[block][Orientation][2]

    return love.math.random(#shapeData), 1

end

-- Block Rotations

function tetras.func.cycleOrientation()

    if Orientation == shapeOrientations[block] then
        Orientation = 1
    else
        Orientation = Orientation + 1
    end

    blockWidth = shapeDimensionsDetails[block][Orientation][1]
    blockHeight = shapeDimensionsDetails[block][Orientation][2]

    tetras.func.blockXCollision()
end

-- Block Fall --

function tetras.func.fall(forceFall, dt)

    if isFalling then

        if forceFall then
            gravity = 15
            math.floor(deltaTmp)
        else
            gravity = 1
        end
    
        deltaTmp = deltaTmp + (dt * gravity)

        if delta < deltaTmp then
            tetras.func.fallCollision()

            delta = math.floor(deltaTmp)
            
            blockPositionY = delta
        end
    end

end



-- Block Collision --

function tetras.func.blockXCollision()
    if blockPositionX + blockWidth > WIDTH then
        blockPositionX = blockPositionX - ((blockPositionX + (blockWidth - 1)) - WIDTH)
    end
end

function tetras.func.fallCollision()
    if blockPositionY + blockHeight > HEIGHT then
        isFalling = false
        tetras.func.newShape()
    else
        local numCollitions = 0
        for col = 0, blockHeight - 1 do
            for row = 0, blockWidth - 1 do
                if shapeData[block][Orientation][col + 1][row + 1] == 1 then
                    if gameArea.func.checkBlock(blockPositionX + row, blockPositionY + col + 1) ~= 0 then
                        numCollitions = numCollitions + 1
                    end
                end
            end
        end
        if numCollitions > 0 then
            isFalling = false
            tetras.func.newShape()
        end
    end
end

-- New Block -- 

function tetras.func.newShape()
    delta = 1
    deltaTmp = 1

    tetras.func.addShape(blockPositionX, blockPositionY, block, Orientation)

    tetras.func.selectBlock()

    blockSprite = love.graphics.newImage(blockColours[block + 1])
    
    isFalling = true
end

-- Keyboard Input --

function tetras.func.keypress(key)
    if key == "up" then
        tetras.func.cycleOrientation()
    elseif key == "right" then
        if blockPositionX + blockWidth - 1 ~= WIDTH then
            blockPositionX = blockPositionX + 1
        end
    elseif key == "left" then
        if blockPositionX ~= 1 then
            blockPositionX = blockPositionX - 1
        end
    elseif key == "escape" then
        love.event.quit()
    end
end

--

function tetras.func.addShape(x, y, block, orient)
    for col = 0, shapeDimensionsDetails[block][orient][1] - 1 do
        for row = 0, shapeDimensionsDetails[block][orient][2] - 1 do
            if shapeData[block][orient][row + 1][col + 1] == 1 then
                gameArea.area[y + row][x + col] = block
            end
        end
    end
end










function round(num, idp) -- Rounding a number| Code from:- https://love2d.org/forums/memberlist.php?mode=viewprofile&u=103181
    local mult = 10 ^ (idp or 0)
    return math.floor(num * mult + 0.5) / mult
end
