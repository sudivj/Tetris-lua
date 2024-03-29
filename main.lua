require("src/render")
require("src/gameArea")
require("src/home")
require("src/scores")
require("src/log")

WIDTH = 10
HEIGHT = 20

SCORE = 0

GAMESTATE = false

function love.load()
    FONT = love.graphics.setNewFont("fonts/Monocraft.otf", 32)
    FONT:setFilter("nearest", "nearest")
    print("> Game log in log.txt.")
    create_log_file()
    home.load()
end

function love.update(dt)
    if GAMESTATE == true then
        game.update(dt)
    else
        home.update(dt)
    end
    -- if music_id == 4 then
    --     home.settings.music:stop()
    -- else
        
    -- end
    home.settings.music:play()
end

function love.draw()
    if GAMESTATE then
        game.draw()
    else
        home.draw()
    end
end

function love.keypressed(key, scancode)
    if GAMESTATE then
        game.keypress(key)
    else
        home.buttons.onClick(key)
    end
    if key == "escape" then
        print_to_log("> Exiting game.")
        love.event.quit()
    end
    if key == "x" then
        GAMESTATE = false
    end
end
