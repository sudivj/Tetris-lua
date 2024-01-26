FILENAME = "game_scores.txt"

function write_score_to_file(score)
    local file = io.open(FILENAME, "a")
    file:write('\n'..score)
    file:close()
end

function file_exits()
    local file = io.open(FILENAME, "r")
    if file ~= nil then
        io.close(file)
        return true
    else
        return false
    end
end

function get_no_of_lines_in_file()
    local ctr = 0
    for _ in io.lines(FILENAME) do
        ctr = ctr + 1
    end
    return ctr
end

function read_lines(from, to)
    local res = {}
    local ctr = 0
    for line in io.lines(FILENAME) do
        ctr = ctr + 1
        if ctr >= from and ctr <= to then
            if ctr == 1 then
                table.insert(res, line)
            else
                table.insert(res, tonumber(line))
            end
        end
    end
    return res
end

function set_highscore(highscore)
    local file = io.open(FILENAME, "r")
    local file_data = {}
    for line in file:lines() do
        table.insert(file_data, line)
    end
    io.close(file)

    file_data[3] = tostring(highscore)

    file = io.open(FILENAME, "w")
    for index,value in ipairs(file_data) do
        file:write(value..'\n')
    end
    io.close(file)
end

function create_file()
    local file = io.open(FILENAME, "w")
    file:write("---SCORES---\n")
    file:write("\n0\n")
    file:close()
end

function get_highscore()
    local ctr = 0
    for line in io.lines(FILENAME) do
        ctr = ctr + 1
        if (ctr == 3) then
            return line
        end
    end
end

scroll_index = 1

function display()
    love.graphics.print("press left arrow to go to home", 0, 0, 0, 0.5)
    love.graphics.print("---SCORES---", ((32 * 16) - (750) / 2), 32, 0)
    local temp = read_lines(scroll_index + 4, (scroll_index + 4) + 21)
    local hs = get_highscore()
    love.graphics.print("Highscore - "..hs, 10, 96, 0)
    for i,v in ipairs(temp) do
        local print_score = "Score "..(i + (scroll_index - 1)).." - "..v
        love.graphics.print(print_score, 10, (i * 32) + 128, 0)
    end
end

function scroll_scores(key)
    if get_no_of_lines_in_file() - 4 > 20 then
        if scroll_index + 20 < get_no_of_lines_in_file() - 3 and key == "down" then
            scroll_index = scroll_index + 1
        end
        if scroll_index > 1 and key == "up" then
            scroll_index = scroll_index - 1
        end
    end
end