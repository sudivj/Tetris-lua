require("src/scores")

local screen = 1

themes = {"DEFAULT", "NORD"}
music = {
    love.audio.newSource("music/A-TYPE.mp3", "stream"),
    love.audio.newSource("music/B-TYPE.mp3", "stream"),
    love.audio.newSource("music/C-TYPE.mp3", "stream"),
    love.audio.newSource("music/empty-10.mp3", "stream")
}

local music_id = 1 -- Default music
local theme_id = 1 -- Default theme

bool_to_number = {[true] = 1, [false] = 0}

home = {}

home.settings = {}
home.settings.theme = themes[theme_id]
home.settings.music = music[music_id]

home.buttons = {}
home.buttons.id = {1, 1, 1, 1, 1}
home.buttons.names = {
    {"PLAY"}, {"SCORES"}, {"A-TYPE", "B-TYPE", "C-TYPE", "NONE"},
    {"DEFAULT THEME", "NORD THEME"}, {"QUIT"}
}

-- home.buttons.func = {
--     play_game()
-- }

button_id = 1 -- Default play button

function home.load()
    print_to_log("=> Menu loaded")
    home.title = love.graphics.newImage(
                     "sprites/" .. home.settings.theme .. "/" .. "TETRIS.png")
    home.cursor = love.graphics.newImage("sprites/cursor.png")
end

local count = 0

function home.update(dt)
    count = count + 0.1
    if count > 360 then count = 0 end
end

function home.draw()
    local MENUSTART = 300
    x = math.floor(math.sin(count) * 5)
    x = x * bool_to_number[(love.keyboard.isDown("right") ~= true)]
    -- love.graphics.draw(home.cursor, (32 * 4) + x,
    --                    MENUSTART + (80 * (button_id - 1)))
    if screen == 1 then
        love.graphics.draw(home.cursor, (32 * 4) + x,
                           MENUSTART + (80 * (button_id - 1)))
        love.graphics.draw(home.title, (((32 * 16) - (672 / 1.5)) / 2),
                           100 + (math.floor(math.sin(count) / 1) * 2), 0,
                           (1 / 1.5))
        -- love.graphics.print("PLAY", (32 * 7), MENUSTART)
        for i = 1, #home.buttons.names do
            love.graphics.print(home.buttons.names[i][home.buttons.id[i]],
                                (32 * 5), MENUSTART + (80 * (i - 1)))
        end
    elseif screen == 2 then
        display()
    end
end

function home.buttons.onClick(key)
    if GAMESTATE == false then
        if screen == 1 then
            if key == "down" then
                if button_id == 5 then
                    button_id = 1
                else
                    button_id = button_id + 1
                end
            end
            if key == "up" then
                if button_id == 1 then
                    button_id = 5
                else
                    button_id = button_id - 1
                end
            end
            if key == "return" then
                if button_id == 1 then
                    print_settings()
                    GAMESTATE = true
                    game.load()
                elseif button_id == 2 then
                    scroll_index = 1
                    dispaly_score()
                elseif button_id == 5 then
                    print_to_log("> Exiting game.")
                    love.event.quit()
                end
            end
            if key == "right" then
                if button_id == 3 then
                    change_music()
                    home.buttons.id[3] = music_id
                end
                if button_id == 4 then
                    change_theme()
                    home.buttons.id[4] = theme_id
                    home.title = love.graphics.newImage("sprites/" ..
                                                            home.settings.theme ..
                                                            "/" .. "TETRIS.png")
                end
            end
        end
        if screen == 2 then
            if key == "left" then 
                print_to_log("   > Exiting score menu.")
                screen = 1 
            end
            scroll_scores(key)
        end
    end
end

function print_settings()
    print_to_log("   > Settings loaded.")
    print_to_log("    |- > Music: " .. home.buttons.names[3][home.buttons.id[3]])
    print_to_log("    |- > Theme: " .. home.buttons.names[4][home.buttons.id[4]])
end

function dispaly_score()
    if not file_exits() then
        screen = 2
        create_file()
    end
    screen = 2
    print_to_log("   > Displaying scores.")
end

function change_music()
    home.settings.music:stop()
    local prev_music = music_id
    music_id = music_id + 1
    if music_id > 4 then music_id = 1 end
    home.settings.music = music[music_id]
    print_to_log("   > Settings Changed - Music: "..home.buttons.names[3][prev_music].." > "..home.buttons.names[3][music_id])
end

function change_theme()
    local prev_theme = theme_id
    theme_id = theme_id + 1
    if theme_id > 2 then theme_id = 1 end
    home.settings.theme = themes[theme_id]
    print_to_log("   > Settings Changed - Theme: "..home.buttons.names[4][prev_theme].." > "..home.buttons.names[4][theme_id])
end
